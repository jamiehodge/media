module Media
  class Filter
    class Chain
      attr_reader :filters

      def initialize(args={}, &block)
        @filters = args.fetch(:filters, [])

        block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
      end

      def to_s
        filters.join(', ')
      end

      def add_filter(name, &block)
        Filter.new(name: name, &block).tap {|filter| filters << filter }
      end
      alias_method :filter, :add_filter
    end
  end
end
