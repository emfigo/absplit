Gem::Specification.new do |s|
  s.name           = 'absplit'
  s.version        = '0.0.1'
  s.date           = "#{Time.now.strftime("%Y-%m-%d")}"
  s.summary        = 'ABSplit'
  s.license        = 'MIT'
  s.description    = 'A/B testing gem'
  s.authors        = ['Enrique Figuerola']
  s.email          = 'hard_rock15@msn.com'
  s.files          = ['lib/a_b_split.rb']
  s.require_paths  = ['lib']
  s.homepage       = 'https://github.com/emfigo/absplit'

  s.add_development_dependency(%q<rspec>, [">= 3.0.0"])
  s.add_development_dependency(%q<rake>, [">= 0"])
end
