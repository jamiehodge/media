module Media
  class Option
    def initialize(args)
      @key   = args.fetch(:key)
      @value = args.fetch(:value, true)
    end
    
    def to_a
      case @value
      when TrueClass  then ["-#{@key}"]
      when FalseClass then ["-no#{@key}"]
      else                 ["-#{@key}", @value.to_s]
      end
    end
  end
end