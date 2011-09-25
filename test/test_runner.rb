require 'helper'
require 'json'

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

    # should "print the result as a json string by default" do
    #   out = silence_stream(STDOUT) do
    #     runner = Stockery::Runner.new(%w(-q AAPL))
    #     runner.run!
    #   end

    #   puts out.to_s
    #   json = JSON.parse(out.to_s)
    #   # assert_match out.to_s, "/Quotes at/"
    # end

    # should "print the result when passing print output argument" do
    #   out = silence_stream(STDOUT) do
    #     runner = Stockery::Runner.new(%w(-q AAPL -o print))
    #     runner.run!
    #   end

    #   assert_match out.to_s, "/Quotes at/"
    # end

    # should "print its version" do
    #   out = silence_stream(STDOUT) do
    #     runner = Stockery::Runner.new(%w(-v))
    #     runner.run!
    #   end

    #   assert_equal out.to_s, Stockery::VERSION
    # end
  end
end
