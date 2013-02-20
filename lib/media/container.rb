require 'json'
require 'ostruct'

require_relative 'command/probe'
require_relative 'option'

module Media
  class Container
    
    attr_reader :url, :options
    
    def initialize(args)
      @url   = args.fetch(:url)
      @probe = args.fetch(:probe, Command::Probe)
      @options = args.fetch(:options, []) + required_options
    end
    
    def format
      OpenStruct.new(metadata['format'])
    end
    
    def streams(args={})
      type = args.fetch(:type, /.*/)
      
      metadata['streams'].select {|s| s['codec_type'].match(type)}.
        map {|s| OpenStruct.new(s)}
    end
    
    private
    
    def metadata
      @metadata ||= JSON.parse(probe.out)
    end
    
    def probe
      @probe.new(input: @url, options: options).call
    end
    
    def required_options
      [ 
        Option.new(key: 'print_format', value: 'json'),
        Option.new(key: 'show_format'),
        Option.new(key: 'show_streams')
      ]
    end
  end
end