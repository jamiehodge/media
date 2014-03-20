module Media
  module Helper
    class Size
      def initialize(args)
        @width  = args.fetch(:width)
        @height = args.fetch(:height)
      end

      def to_s
        [@width, @height].join('x')
      end
    end
  end
end
