require 'helper'
require 'media/option'

module Media
  class TestOption < MiniTest::Unit::TestCase
    
    def subject
      Option
    end
    
    def test_option
      assert_equal '-foo bar', subject.new(key: 'foo', value: 'bar').to_s
    end
    
    def test_true_flag
      assert_equal '-foo', subject.new(key: 'foo').to_s
    end
    
    def test_false_flag
      assert_equal '-nofoo', subject.new(key: 'foo', value: false).to_s
    end
  end
end