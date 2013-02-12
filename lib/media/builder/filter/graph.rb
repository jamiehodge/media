require_relative '../../filter/chain'

require_relative 'chain'

module Media
  module Builder
    module Filter
      module Graph
        
        module ClassMethods
          
          def build(&blk)
            graph = new
          
            if block_given?
              @context = eval('self', blk.binding)
              graph.instance_eval(&blk)
            end
            graph
          end
        end
        
        module InstanceMethods
          
          def chain(&blk)
            chains << Media::Filter::Chain.extend(Chain).build(&blk)
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