require 'helper'
require 'media/input'

module Media
  class TestInput < MiniTest::Unit::TestCase
    
    def test_to_s
      input = Input.new(url: 'url', options: [['option']])
      
      assert_equal([['option'], ['-i', 'url']], input.to_a)
    end
  end
end