Gem::Specification.new do |s|
  s.name           = 'a_b_split'
  s.version        = '0.1.0'
  s.date           = "#{Time.now.strftime("%Y-%m-%d")}"
  s.summary        = 'ABSplit'
  s.license        = 'MIT'
  s.description    = 'A/B split testing gem'
  s.authors        = ['Enrique Figuerola']
  s.email          = 'hard_rock15@msn.com'
  s.files          = Dir.glob('lib/**/*')
  s.require_paths  = ['lib']
  s.homepage       = 'https://github.com/emfigo/absplit'

  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'pry', '~> 0.9'
  s.add_development_dependency 'rake', '~> 10.3'
end
