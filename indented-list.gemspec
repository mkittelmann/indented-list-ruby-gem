Gem::Specification.new do |s|
  s.name        = 'indented-list'
  s.version     = '0.0.2'
  s.date        = '2017-04-27'
  s.summary     = "Parses whitespace indented nested lists into a Ruby object"
  s.description = "Parses whitespace indented nested lists into a Ruby object of nested Hashes and Arrays."
  s.authors     = ["Maike Kittelmann"]
  s.email       = 'kittelmann@sub.uni-goettingen.de'
  s.files       = Dir['lib/*.rb'] + Dir['lib/indented-list/*.rb'] + Dir['test/*']
  s.homepage    = 'http://rubygems.org/gems/indented-list'
  s.license       = 'MIT'
end