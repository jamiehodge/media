require_relative 'filter/argument'
require_relative 'filter/chain'
require_relative 'filter/graph'
require_relative 'helper/label'

module Media
  class Filter
    attr_reader :name
    
    def initialize(args, &block)
      @name        = args.fetch(:name)
      @expressions = Array args.fetch(:expressions, [])
      @arguments   = Array args.fetch(:arguments, [])
      @inputs      = Array args.fetch(:inputs, [])
      @outputs     = Array args.fetch(:outputs, [])
      
      block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
    end
    
    def to_s      
      [inputs, filter, outputs].reject(&:empty?).join(' ')
    end
    
    def inputs(*value)
      return @inputs if value.empty?
        
      @inputs = value.map {|name| Helper::Label.new(name: name)}
    end
    alias_method :inputs=, :inputs
    
    def outputs(*value)
      return @outputs if value.empty?
      
      @outputs = value.map {|name| Helper::Label.new(name: name)}
    end
    alias_method :outputs=, :outputs
    
    def arguments(value=nil)
      return @arguments unless value
      
      @arguments = value.map {|k,v| Argument.new(key: k, value: v)}
    end
    alias_method :arguments=, :arguments
    
    def expressions(*value)
      return @expressions if value.empty?
      
      @expressions = value
    end
    alias_method :expressions=, :expressions
    
    private
    
    def filter
      [
        name,
        [
          expressions.join('|'), 
          arguments.join(':')
        ].reject(&:empty?).join(':')
      ].reject(&:empty?).join('=')
    end
  end
end