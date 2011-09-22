require 'open-uri'
require 'json'

module Stocky
  GOOGLE = "GOOGLE"
  YAHOO = "YAHOO"

  ROOT = File.expand_path(File.dirname(__FILE__))
  
  autoload :Runner,             "#{ROOT}/stocky/runner" 
  autoload :Quote,              "#{ROOT}/stocky/quote" 
end

class String
  def red; colorize(self, "\e[31m"); end
  def green; colorize(self, "\e[1m\e[32m"); end
  def red_bg; colorize(self, "\e[41m"); end
  def green_bg; colorize(self, "\e[31m\e[42m"); end

  def colorize(text, color_code)  
    "#{color_code}#{text}\e[0m" 
  end
end

