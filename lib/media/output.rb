require_relative 'option'

module Media
  class Output
    
    attr_reader :options, :maps
    
    def initialize(args, &block)
      @url     = args.fetch(:url) { raise ':url required'}
      @options = Array args.fetch(:options, [])
      @maps    = Array args.fetch(:maps, [])
      
      block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
    end
    
    def to_a
      (options + maps << graph).compact.map(&:to_a) + [@url]
    end
    
    def options(value=nil)
      return @options unless value
        
      @options = value.map {|k,v| Option.new(key: k, value: v)}
    end
    alias_method :options=, :options
    
    def maps(*value)
      return @maps if value.empty?
      
      @maps = value.map {|v| Option.new(key: 'map', value: v)}
    end
    alias_method :maps=, :maps
    
    def label(name)
      Media.label(name)
    end
    
    def graph(&block)
      return @graph unless block_given?
      
      Filter::Graph.new(&block).tap do |graph|
        @graph = Option.new(key: 'filter_complex', value: result)
      end
    end
    alias_method :graph=, :graph
  end
end