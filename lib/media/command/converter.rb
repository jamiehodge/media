require_relative 'subshell'
require_relative 'progress'
require_relative '../option'

module Media
  module Command
    class Converter
      
      attr_accessor :options, :inputs, :outputs
      
      def initialize(args={}, &block)
        @options = Array args.fetch(:options, [])
        @inputs  = Array args.fetch(:inputs, [])
        @outputs = Array args.fetch(:outputs, [])
        
        @cmd      = args.fetch(:cmd, 'ffmpeg')
        @subshell = args.fetch(:subshell, Subshell)
        @progress = args.fetch(:progress, Progress)
        
        block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
      end
      
      def call(&blk)
        progress = @progress.new
        
        process = @subshell.new(cmd: to_a).call do |line|   
          progress.update(line, &blk)
        end
        progress.complete(&blk) if process.success?
        
        process
      end
      
      def to_a
        [
          @cmd,
          (required_options + options).map(&:to_a),
          inputs.map(&:to_a),
          outputs.map(&:to_a)
        ].flatten
      end
      
      def to_s
        to_a.join(' ')
      end
      
      def options(value=nil)
        return @options unless value
        
        @options = value.map {|k,v| Option.new(key: k, value: v)}
      end
      alias_method :options=, :options
      
      def add_input(url, &block)
        Input.new(url: url, &block).tap {|input| inputs << input }
      end
      alias_method :input, :add_input
      
      def add_output(url, &block)
        Output.new(url: url, &block).tap {|output| outputs << output }
      end
      alias_method :output, :add_output
      
      private
      
      def required_options
        [
          Option.new(key: 'v', value: 'info')
        ]
      end
    end
  end
end