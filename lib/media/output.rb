require_relative 'option'

module Media
  class Output
    
    attr_reader :options
    
    def initialize(args, &blk)
      @url  = args.fetch(:url)
      @options = Array args.fetch(:options, [])
    end
    
    def to_s
      [options, @url].join(' ')
    end
  end
end