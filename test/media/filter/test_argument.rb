require 'helper'
require 'media/filter/argument'

module Media
  class Filter
    class TestArgument < MiniTest::Unit::TestCase
    
      def subject
        Argument
      end
    
      def test_option
        assert_equal 'foo=bar', subject.new(key: 'foo', value: 'bar').to_s
      end
    
      def test_true_flag
        assert_equal 'foo', subject.new(key: 'foo').to_s
      end
      
      def test_value_escaping
        assert_equal 'foo=\[\]\=\;\,', subject.new(key: 'foo', value: '[]=;,').to_s
      end
    end
  end
end