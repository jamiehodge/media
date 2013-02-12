require 'helper'
require 'media/filter/chain'

module Media
  class Filter
    class TestChain < MiniTest::Unit::TestCase
      
      def test_to_s
        assert_equal('a, b, c', Chain.new(filters: %w(a b c)).to_s)
      end
    end
  end
end