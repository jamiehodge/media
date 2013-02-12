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
        @subshell.new(cmd: to_s).call
      end
      
      def to_s
        [@cmd, @options, @input].reject(&:empty?).join(' ')
      end
    end
  end
end