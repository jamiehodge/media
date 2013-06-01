require 'open3'
require 'forwardable'

module Media
  module Command
    class Subshell
      extend Forwardable
      def_delegators :status, :pid, :exitstatus, :termsig, :stopsig
    
      attr_reader :out, :error, :status
    
      def initialize(args)
        @cmd = Array(args.fetch(:cmd))
      end
    
      def call
        ENV['CLICOLOR'] = nil
        ENV['AV_LOG_FORCE_COLOR'] = nil
        
        @out, @error, @status = Open3.popen3(*@cmd) {|stdin,stdout,stderr,thread|
          
          out = Thread.new do
            stdout.each_with_object([]) do |line, memo|
              memo << line
              yield line.strip if block_given?
            end.join
          end
          
          err = Thread.new do
            stderr.each_with_object([]) do |line, memo|
              memo << line
              yield line.strip if block_given?
            end.join
          end
          
          stdin.close
          
          [out.value, err.value, thread.value]
        }
        self
      end
    
      def success?
        exitstatus == 0
      end
    end
  end
end