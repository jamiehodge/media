require_relative 'media/version'

require_relative 'media/command'
require_relative 'media/container'
require_relative 'media/filter'
require_relative 'media/input'
require_relative 'media/option'
require_relative 'media/output'
require_relative 'media/helper'

module Media
  extend self
  
  def convert(&block)
    Media::Command::Converter.new(&block)
  end
  
  def size(args)
    Media::Helper::Size.new(args)
  end
  
  def label(name)
    Media::Helper::Label.new(name: name)
  end
end