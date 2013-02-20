require_relative 'subshell'

module Media
  module Command
    class Probe
      
      def initialize(args)
        @options = Array args.fetch(:options, [])
        @input   = args.fetch(:input)
        
        @cmd      = args.fetch(:cmd, 'ffprobe')
        @subshell = args.fetch(:subshell, Subshell)
      end
      
      def call
        @subshell.new(cmd: to_a).call
      end
      
      def to_a
        [
          @cmd,
          @options.map(&:to_a),
          @input
        ].flatten
      end
    end
  end
end