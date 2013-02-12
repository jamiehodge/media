require 'open3'
require 'forwardable'

module Media
  module Command
    class Subshell
      extend Forwardable
      def_delegators :status, :pid, :exitstatus, :termsig, :stopsig
    
      attr_reader :out, :error, :status
    
      def initialize(args)
        @cmd = args.fetch(:cmd)
      end
    
      def call
        @out, @error, @status = Open3.capture3(@cmd)
        self
      end
    
      def success?
        exitstatus == 0
      end
    end
  end
end