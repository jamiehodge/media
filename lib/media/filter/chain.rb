module Media
  class Filter
    class Chain
      attr_reader :filters
      
      def initialize(args={}, &blk)
        @filters = args.fetch(:filters, [])
      end
      
      def to_s
        filters.join(', ')
      end
    end
  end
end