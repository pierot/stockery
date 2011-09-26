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

require 'stringio'

def capture_output(&block)
  original_stdout = $stdout

  $stdout = fake = StringIO.new
  $stdout.flush

  begin
    yield
  ensure
    $stdout = original_stdout
    $stdout.flush
  end

  fake.string
end

def capture_error(&block)
  original_stdout = $stderr

  $stderr = fake = StringIO.new
  $stderr.flush

  begin
    yield
  ensure
    $stderr = original_stdout
    $stderr.flush
  end

  fake.string
end
