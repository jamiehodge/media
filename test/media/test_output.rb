require 'helper'
require 'media/output'

module Media
  class TestOutput < MiniTest::Unit::TestCase
    
    def test_to_s
      output = Output.new(url: 'url', options: 'options')
      
      assert_equal('options url', output.to_s)
    end
  end
end