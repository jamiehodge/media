require_relative 'chain'

module Media
  class Filter
    class Graph
      attr_reader :chains
      
      def initialize(args={}, &block)
        @chains = args.fetch(:chains, [])
        
        block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
      end
      
      def to_s
        chains.join('; ')
      end
      
      def add_chain(&block)
        @chains << Filter::Chain.new(&block)
      end
      alias_method :chain, :add_chain
    end
  end
end