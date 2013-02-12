require 'helper'
require 'media/label'

module Media
  class TestLabel < MiniTest::Unit::TestCase
    
    def test_to_s
      assert_equal '[foo]', Label.new(name: 'foo').to_s
    end
  end
end