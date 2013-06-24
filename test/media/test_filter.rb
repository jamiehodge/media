require 'helper'
require 'media/filter'

module Media
  class TestFilter < MiniTest::Unit::TestCase
    
    def test_to_s
      filter = Filter.new(
        name: 'name',
        expressions: ['expressions','expressions'], 
        arguments: 'arguments', 
        inputs: 'inputs',
        outputs: 'outputs'
      )
      
      assert_equal('inputs name=expressions|expressions:arguments outputs', filter.to_s)
    end
  end
end