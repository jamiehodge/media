require 'helper'
require 'media/command/probe'

module Media
  module Command
    class TestProbe < MiniTest::Unit::TestCase
      
      def subject(args={})
        @subject ||= Probe.new(args.merge(subshell: subshell))
      end
      
      def subshell
        @subshell ||= MiniTest::Mock.new
      end
      
      def after
        subshell.verify
      end
      
      def test_call
        subshell.expect(:new, subshell, [cmd: ['ffprobe', 'input']])
        subshell.expect(:call, true)
        
        subject(input: ['input']).call
      end
      
      def test_call_with_input
        assert_equal ['ffprobe', 'input'], subject(input: ['input']).to_a
      end
      
      def test_call_with_all
        assert_equal ['ffprobe', 'option', 'input'],
          subject(options: [['option']], input: ['input']).to_a
      end
    end
  end
end