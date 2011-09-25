require 'helper'

class TestStockeryRunner < Test::Unit::TestCase
  context "A Stockery::Runner instance" do
    setup do

    end

    should "parse its options" do
      runner = Stockery::Runner.new(%w(-q AAPL -s YAHOO -o print))

      assert_equal runner.options[:source], "YAHOO"
      assert_equal runner.options[:quotes], "AAPL"
      assert_equal runner.options[:output], "print"
    end

    # should "print the result when passing print output argument" do
    #   out = capture do
    #     runner = Stockery::Runner.new(%w(-q AAPL -o print))
    #     runner.run!
    #   end

    #   assert_match out.string, "/Quotes at/"
    # end

    # should "print its version" do
    #   out = capture do
    #     runner = Stockery::Runner.new(%w(-v))
    #     runner.run!
    #   end

    #   assert_equal out.string, Stockery::VERSION
    # end

  end
end
