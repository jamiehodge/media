require 'helper'
require 'media/filter/graph'

module Media
  class Filter
    class TestGraph < MiniTest::Unit::TestCase
      
      def test_to_s
        assert_equal('a; b; c', Graph.new(chains: %w(a b c)).to_s)
      end
    end
  end
end