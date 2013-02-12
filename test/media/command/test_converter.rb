require 'helper'
require 'media/command/converter'

module Media
  module Command
    class TestConverter < MiniTest::Unit::TestCase
      
      def subject(args={})
        @subject ||= Converter.new(args.merge(subshell: subshell))
      end
      
      def subshell
        @subshell ||= MiniTest::Mock.new
      end
      
      def after
        subshell.verify
      end
      
      def test_empty_call
        subshell.expect(:new, subshell, [cmd: 'ffmpeg'])
        subshell.expect(:call, true)
        
        subject.call
      end
      
      def test_with_options
        assert_equal 'ffmpeg options', subject(options: ['options']).to_s
      end
      
      def test_call_with_inputs
        assert_equal 'ffmpeg inputs', subject(inputs: ['inputs']).to_s
      end
      
      def test_call_with_outputs
        assert_equal 'ffmpeg outputs', subject(outputs: ['outputs']).to_s
      end
      
      def test_call_with_all
        assert_equal 'ffmpeg options inputs outputs',
          subject(options: ['options'], inputs: ['inputs'], outputs: ['outputs']).to_s
      end
    end
  end
end