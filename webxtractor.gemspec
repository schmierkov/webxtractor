Gem::Specification.new do |s|
  s.name                     = "webxtractor"
  s.version                  = "0.0.1"
  s.date                     = "2016-01-24"
  s.summary                  = "Extracts meta informations from a HTML Page"
  s.description              = "A simple content extractor"
  s.authors                  = ["Sirko Sittig"]
  s.email                    = "github@schmierkov.de"
  s.files                    = ["lib/webxtractor.rb"]
  s.homepage                 = "https://github.com/schmierkov/webxtractor"
  s.add_runtime_dependency     "nokogiri"
  s.add_development_dependency "pry-byebug"
end
