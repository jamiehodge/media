require_relative 'media/version'

require_relative 'media/command'
require_relative 'media/container'
require_relative 'media/filter'
require_relative 'media/input'
require_relative 'media/label'
require_relative 'media/option'
require_relative 'media/output'
require_relative 'media/size'

require_relative 'media/builder/command/converter'

module Media
  extend self
  
  def convert(&blk)
    Command::Converter.extend(Builder::Command::Converter).build(&blk)
  end
end