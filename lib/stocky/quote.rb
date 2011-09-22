module Stocky
  class Quote
    attr_accessor :source

    def initialize
      source = Stocky::GOOGLE
    end

    def get_status(symbol)
      result = case source
      when Stocky::GOOGLE then
        fetch_goog(symbol)
      else
        "--"
      end

      result
    end

    def print(stocky_data, do_print = false)
      res = stocky_data
      printed = ""

      unless res.empty?
        printed += "#{res[:name]} on #{res[:market]} @ #{res[:timestamp]}\n"
        printed += " *** MARKET CLOSED ***\n" if Time.now.strftime("%H:%M") > "16:00"
        
        printed_pr = "#{res[:price]} #{res[:change_points]} (#{res[:change_procent]}%)"
        printed += res[:change_points].to_f < 0 ? printed_pr.red : printed_pr.green
      else
        printed += "Stock data invalid or empty"
      end

      puts printed if do_print
      printed
    end

    private

      def fetch_goog(symbol)
        json = open("http://www.google.com/finance/info?client=ig&q=#{symbol}").read
        json = json.sub(/^\n\/\//, '')

        data = JSON.parse(json)[0]
        data_stock = {}
        
        unless data.nil?
          data_stock[:market] = data['e']
          data_stock[:name] = data['t']
          data_stock[:price] = data['l']
          data_stock[:price_currency] = data['l_curr']
          data_stock[:change_points] = data['c']
          data_stock[:change_procent] = data['cp']

          data_stock[:timestamp] = data['ltt']
        end

        data_stock
      end
  end
end
