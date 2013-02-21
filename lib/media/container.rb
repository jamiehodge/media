require 'json'
require 'ostruct'

require_relative 'command/probe'
require_relative 'option'

module Media
  class Container
    
    attr_reader :url
    
    def initialize(args, &block)
      @url   = args.fetch(:url) { raise ':url required'}
      @probe = args.fetch(:probe, Command::Probe)
      @options = args.fetch(:options, [])
      
      block.arity < 1 ? instance_eval(&block) : block.call(self) if block_given?
    end
    
    def options(value=nil)
      return @options + required_options unless value
        
      @options = value.map {|k,v| Option.new(key: k, value: v)}
    end
    alias_method :options=, :options
    
    def format
      OpenStruct.new(metadata['format'])
    end
    
    def streams(type=/.*/)      
      metadata['streams'].select {|s| s['codec_type'].match(type)}.
        map {|s| OpenStruct.new(s)}
    end
    
    def frames
      warn 'show_frames option required' unless metadata['frames']
      
      Array(metadata['frames']).map {|s| OpenStruct.new(s)}
    end
    
    def metadata
      @metadata ||= JSON.parse(probe.out)
    end
    
    private
    
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