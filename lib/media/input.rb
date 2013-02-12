require_relative 'option'
require_relative 'filter/graph'

module Media
  class Input
    attr_reader :options
    
    def initialize(args)
      @url     = args.fetch(:url)
      @options = Array args.fetch(:options, [])
    end
    
    def to_s
      [options, url].reject(&:empty?).join(' ')
    end
    
    private
    
    def url
      Option.new(key: 'i', value: @url).to_s
    end
  end
end