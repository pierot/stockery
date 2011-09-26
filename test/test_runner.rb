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

    should "exit when passing invalid option" do
      out = capture_error do
        begin
          Stockery::Runner.new(%w(--bad-option))
        rescue SystemExit => e
        end
      end
      
      assert_equal "Invalid option.\n", out.to_s
    end

    should "exit when passing no symbols" do
      out = capture_error do
        begin
          runner = Stockery::Runner.new(%w(-o print))
          runner.run!
        rescue SystemExit => e
        end
      end
      
      assert_equal "Stock symbols missing. Usage `stockery -q \"GOOG, MSFT\"\n", out.to_s
    end

    should "print the result as a json string by default" do
      out = capture_output do
        runner = Stockery::Runner.new(%w(-q AAPL))
        runner.run!
      end

      possible_json_data = out.to_s

      begin
        JSON.parse(possible_json_data)

        valid = true
      rescue JSON::ParserError => e
        valid = false 
      end

      assert valid
    end

    should "print the result when passing print output argument" do
      out = capture_output do
        runner = Stockery::Runner.new(%w(-q AAPL -o print))
        runner.run!
      end

      assert_match "Quotes at", out.to_s
    end

    should "print its version" do
      out = capture_output do
        begin
          runner = Stockery::Runner.new(%w(-v))
          runner.run!
        rescue SystemExit => e

        end
      end

      assert_equal Stockery::VERSION + "\n", out.to_s # \n because of exit status
    end
  end
end
