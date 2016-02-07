Gem::Specification.new do |s|
  s.name                     = "webxtractor"
  s.version                  = "0.0.2"
  s.license                  = "MIT"
  s.date                     = "2016-01-24"
  s.summary                  = "Extracts meta informations from a HTML Page"
  s.description              = "A simple content extractor"
  s.authors                  = ["Sirko Sittig"]
  s.email                    = "github@schmierkov.de"
  s.files                    = ["lib/webxtractor.rb"]
  s.homepage                 = "https://github.com/schmierkov/webxtractor"
  s.add_runtime_dependency     "nokogiri", '~> 1.6', '>= 1.6.7.2'
  s.add_development_dependency "pry-byebug", '~> 3.3', '>= 3.3.0'
end
