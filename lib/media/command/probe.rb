require_relative 'child_process'

module Media
  module Command
    class Probe

      def initialize(args)
        @options = Array args.fetch(:options, [])
        @input   = args.fetch(:input)

        @command       = args.fetch(:command, 'ffprobe')
        @child_process = args.fetch(:child_process, ChildProcess)
      end

      def call
        @child_process.new(to_a).call
      end

      def to_a
        [
          @command,
          @options.map(&:to_a),
          @input
        ].flatten
      end
    end
  end
end
