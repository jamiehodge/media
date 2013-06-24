require 'helper'
require 'media/command/probe'

module Media
  module Command
    class TestProbe < MiniTest::Unit::TestCase
      
      def subject(args={})
        @subject ||= Probe.new(args.merge(child_process: child_process))
      end
      
      def child_process
        @child_process ||= MiniTest::Mock.new
      end
      
      def after
        child_process.verify
      end
      
      def test_call
        child_process.expect(:new, child_process, [command: ['ffprobe', 'input']])
        child_process.expect(:call, child_process)
        child_process.expect(:success?, false)
        
        child_process.expect(:new, child_process, [command: ['ffprobe', 'input']])
        child_process.expect(:call, child_process)
        child_process.expect(:success?, true)
        
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