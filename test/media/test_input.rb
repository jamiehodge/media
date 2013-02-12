require 'helper'
require 'media/input'

module Media
  class TestInput < MiniTest::Unit::TestCase
    
    def test_to_s
      input = Input.new(url: 'url', options: 'options')
      
      assert_equal('options -i url', input.to_s)
    end
  end
end