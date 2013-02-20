module Media
  module Command
    class Progress
      
      DURATION = /Duration: (\d+):(\d+):(\d+.\d+), start: (\d+.\d+)/
      TIME     = /time=(\d+):(\d+):(\d+.\d+)/
      
      attr_reader :duration, :time
      
      def initialize(args={})
        @duration = args.fetch(:duration, 0.0)
        @time     = args.fetch(:time, 0.0)
      end
      
      def update(line)
        case line
        when DURATION
          @duration = ($1.to_i * 3600) + ($2.to_i * 60) + $3.to_f + $4.to_f
          yield self if block_given?
        when TIME
          @time = ($1.to_i * 3600) + ($2.to_i * 60) + $3.to_f
          yield self if block_given?
        end
      end
      
      def complete
        @time = @duration
        yield self if block_given?
      end
      
      def to_f
        time / duration rescue ZeroDivisionError 0.0
      end
    end
  end
end