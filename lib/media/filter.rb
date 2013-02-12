require 'shellwords'

require_relative 'filter/argument'
require_relative 'filter/chain'
require_relative 'filter/graph'
require_relative 'label'

module Media
  class Filter
    attr_reader :name, :arguments, :inputs, :outputs
    
    def initialize(args)
      @name      = args.fetch(:name)
      @arguments = Array args.fetch(:arguments, [])
      @inputs    = Array args.fetch(:inputs, [])
      @outputs   = Array args.fetch(:outputs, [])
    end
    
    def to_s      
      [inputs, filter, outputs].reject(&:empty?).join(' ')
    end
    
    private
    
    def filter
      [name, arguments.join(':')].reject(&:empty?).join('=')
    end
  end
end