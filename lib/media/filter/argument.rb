module Media
  class Filter
    class Argument
      def initialize(args)
        @key   = args.fetch(:key)
        @value = args.fetch(:value, true)
      end
      
      def to_s
        case @value
        when TrueClass, FalseClass then @key
        else                "#{@key}=#{value}"
        end
      end
      
      private
      
      def value
        @value.to_s.gsub(/([\[\]=;,])/, "\\\\\\1")
      end
    end
  end
end