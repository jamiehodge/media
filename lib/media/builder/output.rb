require_relative '../option'
require_relative '../filter/graph'

require_relative 'filter/graph'

module Media
  module Builder
    module Output
      
      module ClassMethods
  
        def build(url, &blk)
          output = new(url: url)
          
          if block_given?
            @context = eval('self', blk.binding)
            output.instance_eval(&blk)
          end
          output
        end
      end

      module InstanceMethods
  
        def option(key, value=true)
          @options << Media::Option.new(key: key, value: value)
        end
    
        def map(value)
          @options << Media::Option.new(key: 'map', value: value)
        end
        
        def graph(&blk)
          @options << Media::Option.new(key: 'filter_complex', 
            value: Media::Filter::Graph.extend(Filter::Graph).build(&blk))
        end
  
        def method_missing(method, *args, &blk)
          @context && @context.send(method, *args, &blk)
          super
        end
      end
      
      def self.extended(receiver)
        receiver.extend(ClassMethods)
        receiver.send(:include, InstanceMethods)
      end
    end
  end
end