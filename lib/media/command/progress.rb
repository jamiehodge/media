module Media
  module Command
    class Progress

      attr_reader :duration, :time

      def initialize(duration = 0, time = 0)
        @duration = duration
        @time     = time
      end

      def parse(str, &block)
        str.split("\n").each do |line|
          d = Parser.new(line, DURATION)
          t = Parser.new(line, TIME)

          @duration = d.to_seconds if d.match? and d.to_seconds > @duration
          @time     = t.to_seconds if t.match? and t.to_seconds > @time

          block.call(self) if t.match?
        end
      end

      def to_f
        return 0.0 if duration == 0
        [time / duration, 1.0].min.round(2)
      end

      def to_s
        to_f.to_s
      end

      private

      DURATION = /Duration: (\d+):(\d+):(\d+.\d+), start: (\d+.\d+)/
      TIME     = /time=(\d+):(\d+):(\d+.\d+)/

      class Parser

        def initialize(str, regex)
          @match = regex.match(str)
          _, @hours, @minutes, @seconds = @match.to_a if @match
        end

        def match?
          !!@match
        end

        def to_seconds
          return unless match?

          result = 0.0
          result += @hours.to_i * 3600
          result += @minutes.to_i * 60
          result += @seconds.to_f
        end
      end
    end
  end
end
