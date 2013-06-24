ENV['CLICOLOR']           = nil
ENV['AV_LOG_FORCE_COLOR'] = nil

require 'forwardable'
require 'open3'

require_relative 'stream'

module Media
  module Command
    class ChildProcess
      extend Forwardable
      
      attr_reader :command, :wait_thread
      
      def initialize(args)
        @command = Array(args.fetch(:command))
      end
      
      def call(&block)
        @in, @out, @error, @wait_thread = Open3.popen3(*command)

        @in.close
        
        @out   = Stream.new(@out)
        @error = Stream.new(@error)
        
        while wait_thread.alive?
          read, _ = IO.select([@out, @error])
          read.each do |stream|
            stream.handle_read(&block)
          end
        end
        
        self
      end
      
      def out
        @out.to_s
      end
      
      def error
        @error.to_s
      end
      
      def_delegators :'wait_thread.value', :exitstatus, :pid, :success?
    end
  end
end