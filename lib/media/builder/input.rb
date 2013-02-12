require_relative 'filter/graph'

module Media
  module Builder
    module Input
      
      module ClassMethods
        
        def build(url, &blk)
          input = new(url: url)
          
          if block_given?
            @context = eval('self', blk.binding)
            input.instance_eval(&blk)
          end
          input
        end
      end
      
      module InstanceMethods
        
        def option(key, value=true)
          @options << Media::Option.new(key: key, value: value).to_s
        end
    
        def graph(&blk)
          @options << Option.new(
            key: 'filter_complex', 
            value: Media::Filter::Graph.extend(Filter::Graph).build(&blk)
          )
        end
        
        def method_missing(method, *args, &blk)
          @context && @context.send(method, *args, &blk)
          super(method, *args, &blk)
        end
      end
      
      def self.extended(receiver)
        receiver.extend(ClassMethods)
        receiver.send(:include, InstanceMethods)
      end
    end
  end
end