$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'mago'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

FIXTURES_PATH = File.expand_path('../fixtures', __FILE__)
MAGO_BIN = File.expand_path('../../bin/mago', __FILE__)

RSpec.configure do |config|

end
