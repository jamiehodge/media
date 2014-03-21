require 'open3'

require_relative 'progress'
require_relative 'result'
require_relative 'stream'

module Media
  module Command
    class ChildProcess

      attr_reader :command, :bufferer, :resulter, :tracker

      def initialize(command, options = {})
        @command  = Array(command)
        @bufferer = options.fetch(:bufferer) { Stream }
        @resulter = options.fetch(:resulter) { Result }
        @tracker  = options.fetch(:tracker)  { Progress }
      end

      def call(duration = 0, &block)
        stdin, stdout, stderr, wait_thread =
          Open3.popen3(environment, *command.map(&:to_s))

        stdin.close
        stderr = bufferer.new(stderr)

        progress = tracker.new(duration)

        while wait_thread.alive?
          read, _ = IO.select([stderr])
          read.each {|io| progress.parse(io.handle_read, &block) }
        end

        resulter.new(stderr.read, stdout.read, wait_thread.value)
      end

      private

      def environment
        { "CLICOLOR" => nil, "AV_LOG_FORCE_COLOR" => nil }
      end
    end
  end
end
