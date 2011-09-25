require 'helper'

class TestStockeryQuote < Test::Unit::TestCase
  context "A Stockery::Quote instance" do
    setup do
      @stock = Stockery::Quote.new
    end

    should "have GOOGLE as default source" do
       assert_equal @stock.source, "GOOGLE"
    end

    should "be able to switch sources" do
      @stock.source = Stockery::YAHOO
      assert_equal @stock.source, Stockery::YAHOO
    end

    should "return not nil when requesting a valid symbol" do
      result = @stock.get_status("AAPL")
      assert_not_nil result 
    end

    should "print out an 'error message' when sending an invalid stock data object" do
      message = @stock.print(nil)
      assert_equal message, "Stock data invalid or empty"
    end

    should "print out a quote message when sending stock data object" do
      result = @stock.get_status("AAPL")
      message = @stock.print(result)
      assert message.length > 0
    end

    should "not print out an 'error message' when sending an valid stock data object" do
      result = @stock.get_status("AAPL")
      message = @stock.print(result)
      assert_not_equal message, "Stock data invalid or empty"
    end
  end
end
