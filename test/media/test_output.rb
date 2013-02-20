require 'helper'
require 'media/output'

module Media
  class TestOutput < MiniTest::Unit::TestCase
    
    def test_to_s
      output = Output.new(url: 'url', options: [['option']])
      
      assert_equal([['option'], 'url'], output.to_a)
    end
  end
end