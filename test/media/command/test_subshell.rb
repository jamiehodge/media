require 'helper'
require 'media/command/subshell'

module Media
  module Command
    class TestSubshell < MiniTest::Unit::TestCase
      
      def subject
        Subshell
      end
      
      def test_stdout
        shell = subject.new(cmd: ['echo', 'hello'])
        
        assert_equal("hello\n", shell.call.out)
      end
      
      def test_stderr
        shell = subject.new(cmd: ['ffprobe'])

        assert_match(/^ffprobe/, shell.call.error)
      end
      
      def test_success
        shell = subject.new(cmd: 'true')
        
        assert(shell.call.success?)
      end
      
      def test_failure
        shell = subject.new(cmd: 'false')
        
        refute(shell.call.success?)
      end
      
      def test_streaming
        shell = subject.new(cmd: ['echo', "hello\n", 'there'])
        
        out = []
        shell.call {|line| out << line}
        
        assert_equal(['hello', 'there'], out)
      end
    end
  end
end