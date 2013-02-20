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
        stub = Class.new do
          def success?; true; end
        end
        
        subshell.expect(:new, subshell, [cmd: ['ffmpeg', '-v', 'info']])
        subshell.expect(:call, stub.new)
        
        subject.call
      end
      
      def test_with_options
        assert_equal ['ffmpeg', '-v', 'info', 'option'], subject(options: [['option']]).to_a
      end
      
      def test_call_with_inputs
        assert_equal ['ffmpeg', '-v', 'info', 'input'], subject(inputs: [['input']]).to_a
      end
      
      def test_call_with_outputs
        assert_equal ['ffmpeg', '-v', 'info', 'output'], subject(outputs: [['output']]).to_a
      end
      
      def test_call_with_all
        assert_equal ['ffmpeg', '-v', 'info', 'option', 'input', 'output'],
          subject(options: [['option']], inputs: [['input']], outputs: [['output']]).to_a
      end
    end
  end
end