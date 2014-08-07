require 'a_b_split'
require 'rspec'

Dir['./spec/support/**/*.rb'].sort.each { |file| require file }

RSpec.configure do |config|
  config.color = true
  config.formatter = 'documentation'
end
