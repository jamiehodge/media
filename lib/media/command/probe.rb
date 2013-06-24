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
        tries   = 3
        process = nil
        
        while tries > 0
          process = @child_process.new(command: to_a).call
          break if process.success?
          tries -= 1
        end
        
        process
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