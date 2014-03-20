require_relative 'option'
require_relative 'filter/graph'

module Media
  class Input

    def initialize(args, &block)
      @url     = args.fetch(:url) { raise ':url required'}
      @options = Array args.fetch(:options, [])

      block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
    end

    def to_a
      (options << graph << url).compact.map(&:to_a)
    end

    def options(value=nil)
      return @options unless value

      @options = value.map {|k,v| Option.new(key: k, value: v)}
    end
    alias_method :options=, :options

    def graph(&block)
      return @graph unless block_given?

      @graph = Option.new(key: 'filter_complex', value: Filter::Graph.new(&block))
    end
    alias_method :graph=, :graph

    private

    def url
      Option.new(key: 'i', value: @url)
    end
  end
end
