# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), 'functions', '*')].each do |function|
  require function
end
