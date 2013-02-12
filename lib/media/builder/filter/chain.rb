require_relative '../filter'

module Media
  module Builder
    module Filter
      module Chain
        
        module ClassMethods
          
          def build(&blk)
            chain = new
          
            if block_given?
              @context = eval('self', blk.binding)
              chain.instance_eval(&blk)
            end
            chain
          end
        end
        
        module InstanceMethods
          
          def filter(name, &blk)
            filters << Media::Filter.extend(Filter).build(name, &blk)
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
end