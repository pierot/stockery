require 'optparse'

module Stockery
  class Runner
    def initialize(argv)
      @argv = argv
      
      # Default options values
      @options = {
        :source          => Stockery::GOOGLE,
        :quotes          => '',
      }

      parse!
    end

    def run!
      if @options[:quotes].length == 0
        abort "Quote symbols missing. Usage `stockery -q \"GOOG, MSFT\""
      end

      puts "Quotes at #{Time.now}\n"
      puts ""

      s_q = Stockery::Quote.new
      s_q.source = @options[:source]
    
      quotes = @options[:quotes].split(',').collect { |q| q.to_s.strip }

      quotes.each do |quote|
        res = s_q.get_status(quote)
        puts s_q.print(res)

        puts "\n"
      end
    end 

    private

      def parse!
        parser.parse! @argv
      end

      def parser
        @parser ||= OptionParser.new do |opts|
          opts.banner = "Usage: stockery [options]"

          opts.separator ""
          opts.separator "Command options:"

          opts.on("-s", "--source HOST", "Stock source (default: #{@options[:source]})")  { |source| @options[:source] = source }
          opts.on("-q", "--quotes 'comma separated'", "Required, no default")             { |quotes| @options[:quotes] = quotes }

          opts.separator ""

          opts.on_tail("-h", "--help", "Show this message")                               { puts opts; exit }
        end
      end
  end
end
