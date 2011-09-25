require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'stockery'

class Test::Unit::TestCase
end

def silence_stream(stream)                                                                                                                                   
  old_stream = stream.dup
  stream.reopen(RUBY_PLATFORM =~ /mswin/ ? 'NUL:' : '/dev/null')
  stream.sync = true                                                                                                                                         

  yield                                                                                                                                                    
ensure                                                                                                                                                       
  stream.reopen(old_stream)                                                                                                                                  
end
