Dir[File.join(File.dirname(__FILE__), *%w(functions *))].each do |function|
  require function
end
