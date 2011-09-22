require 'optparse'

module Stockery
  class Runner
    def initialize(argv)
      @argv = argv
      
      # Default options values
      @options = {
        :source          => Stockery::GOOGLE,
        :quotes          => '',
        :output          => 'json',
      }

      parse!
    end

    def run!
      if @options[:quotes].length == 0
        abort "Quote symbols missing. Usage `stockery -q \"GOOG, MSFT\""
      end

      s_q = Stockery::Quote.new
      s_q.source = @options[:source]
    
      quotes = @options[:quotes].split(',').collect { |q| q.to_s.strip }
      quotes_res = []
      
      quotes.each do |quote|
        quotes_res << s_q.get_status(quote)
      end

      case @options[:output]
      when 'print'
        puts "Quotes at #{Time.now}\n"
        puts ""

        quotes_res.each do |quote|
          puts s_q.print(quote)
          puts "\n"
        end
      when 'json'
        p JSON.generate(quotes_res)
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
          opts.on("-q", "--quotes 'Comma separated'", "Required, no default")             { |quotes| @options[:quotes] = quotes }
          opts.on("-o", "--output 'Output. JSON is default'", "Pass 'print' to print out, 'json' for JSON (default).")  { |output| @options[:output] = output }

          opts.separator ""

          opts.on_tail("-h", "--help", "Show this message")                               { puts opts; exit }
        end
      end
  end
end
