require_relative '../../option'
require_relative '../../input'
require_relative '../../output'

require_relative '../../builder/input'
require_relative '../../builder/output'

module Media
  module Builder
    module Command
      module Converter
      
        module ClassMethods
        
          def build(&blk)
            converter = new
          
            if block_given?
              context = eval('self', blk.binding)
              converter.instance_variable_set(:@context, context)
              
              converter.instance_eval(&blk)
            end
            converter
          end
        end
      
        module InstanceMethods
        
          def option(key, value=true)
            options << Media::Option.new(key: key, value: value)
          end
      
          def input(url, &blk)
            inputs << Media::Input.extend(Builder::Input).build(url, &blk)
          end
      
          def output(url, &blk)
            outputs << Media::Output.extend(Builder::Output).build(url, &blk)
          end
        
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
end
    