require_relative 'chain'

module Media
  class Filter
    class Graph
      attr_reader :chains
      
      def initialize(args={}, &blk)
        @chains = args.fetch(:chains, [])
      end
      
      def to_s
        "\"#{chains.join('; ')}\""
      end
    end
  end
end