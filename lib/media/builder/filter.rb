require_relative '../filter/argument'

module Media
  module Builder
    module Filter
      
      module ClassMethods
        
        def build(name, &blk)
          filter = new(name: name)
          
          if block_given?
            context = eval('self', blk.binding)
            filter.instance_variable_set(:@context, context)
            
            filter.instance_eval(&blk)
          end
          filter
        end
      end
      
      module InstanceMethods
        
        def input(name)
          inputs << Media::Label.new(name: name)
        end
    
        def output(name)
          outputs << Media::Label.new(name: name)
        end
    
        def argument(key, value=true)
          arguments << Media::Filter::Argument.new(key: key, value: value)
        end
        alias :arg :argument
        
        def method_missing(method, *args, &blk)
          @context && @context.send(method, *args, &blk)
        end
      end
      
      def self.extended(receiver)
        receiver.extend(ClassMethods)
        receiver.send(:include, InstanceMethods)
      end
    end
  end
end