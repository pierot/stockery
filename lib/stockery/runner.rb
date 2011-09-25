require 'optparse'

module Stockery
  class Runner
    attr_accessor :options

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
        abort "Stock symbols missing. Usage `stockery -q \"GOOG, MSFT\""
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
        puts JSON.generate(quotes_res)
      end
    end 

    private

      def parse!
        begin
          parser.parse! @argv
        rescue OptionParser::InvalidOption => io
          abort "Invalid option."
        end
      end

      def parser
        @parser ||= OptionParser.new do |opts|
          opts.banner = "Usage: stockery [options]"

          opts.separator ""
          opts.separator "Command options:"

          opts.on("-q", "--query 'Comma separated symbols'", "Required")                    { |quotes| @options[:quotes] = quotes }
          opts.on("-s", "--source 'Google'", "Stock source (default: #{@options[:source]})"){ |source| @options[:source] = source }
          opts.on("-o", "--output 'print'", "Possible values: 'print' and 'json'")          { |output| @options[:output] = output }

          opts.separator ""

          opts.on_tail("-h", "--help", "Show this message")                                 { puts opts; exit }
          opts.on_tail("-v", "--version", "Print version")                                  { puts Stockery::VERSION; exit }
        end
      end
  end
end
