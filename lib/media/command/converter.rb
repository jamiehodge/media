require_relative 'subshell'

module Media
  module Command
    class Converter
      
      attr_accessor :options, :inputs, :outputs
      
      def initialize(args={})
        @options = Array args.fetch(:options, [])
        @inputs  = Array args.fetch(:inputs, [])
        @outputs = Array args.fetch(:outputs, [])
        
        @cmd      = args.fetch(:cmd, 'ffmpeg')
        @subshell = args.fetch(:subshell, Subshell)
      end
      
      def call
        @subshell.new(cmd: to_s).call
      end
      
      def to_s
        [@cmd, options, inputs, outputs].reject(&:empty?).join(' ')
      end
    end
  end
end