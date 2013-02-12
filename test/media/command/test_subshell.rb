require 'helper'
require 'media/command/subshell'

module Media
  module Command
    class TestSubshell < MiniTest::Unit::TestCase
      
      def subject
        Subshell
      end
      
      def test_stdout
        shell = subject.new(cmd: 'echo hello')
        
        assert_equal("hello\n", shell.call.out)
      end
      
      def test_stderr
        shell = subject.new(cmd: 'echo hello 1>&2')
        
        assert_equal("hello\n", shell.call.error)
      end
      
      def test_success
        shell = subject.new(cmd: 'true')
        
        assert(shell.call.success?)
      end
      
      def test_failure
        shell = subject.new(cmd: 'false')
        
        refute(shell.call.success?)
      end
    end
  end
end