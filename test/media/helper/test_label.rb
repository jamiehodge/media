require 'helper'
require 'media/helper/label'

module Media
  class TestLabel < MiniTest::Unit::TestCase
    
    def test_to_s
      assert_equal '[foo]', Helper::Label.new(name: 'foo').to_s
    end
  end
end