module Stockery
  class Quote
    attr_accessor :source

    def initialize
      self.source = Stockery::GOOGLE
    end

    def get_status(symbol)
      result = case source
        when Stockery::GOOGLE then
          fetch_goog(symbol)
        when Stockery::YAHOO then
          fetch_yahoo(symbol)
        else
          abort "No valid source specified. The following source are available: \"GOOGLE\""
        end
      
      result[:time_stamp] = Time.now.getutc
        
      result
    end

    def print(stockery_data, do_print = false)
      res = stockery_data
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
          # data_stock[:price_currency] = data['l_curr']
          data_stock[:change_points] = data['c']
          data_stock[:change_procent] = data['cp']

          # data_stock[:timestamp] = data['ltt']
        end

        data_stock
      end

      def fetch_yahoo(symbol)
        resp = Net::HTTP.get_response(URI.parse("http://download.finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=snl1c1p2x&e=.csv"))
        lines = resp.body.split("\r\n")

        data_stock = {}

        lines.each do |line|
          data = JSON.parse("[#{line}]")

          data_stock[:market] = data[5]
          data_stock[:name] = data[0]
          data_stock[:price] = data[2]
          # data_stock[:price_currency] = data[0]
          data_stock[:change_points] = data[3]
          data_stock[:change_procent] = data[4]

          # data_stock[:timestamp] = data[0]
        end
        
        data_stock
      end
  end
end
