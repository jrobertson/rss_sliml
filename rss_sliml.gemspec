Gem::Specification.new do |s|
  s.name = 'rss_sliml'
  s.version = '0.1.0'
  s.summary = 'Generates an RSS XML stylesheet using a kind of Slim template'
  s.authors = ['James Robertson']
  s.files = Dir['lib/rss_sliml.rb']
  s.add_runtime_dependency('rexle-builder', '~> 0.2', '>=0.2.1')
  s.add_runtime_dependency('line-tree', '~> 0.5', '>=0.5.5')
  s.signing_key = '../privatekeys/rss_sliml.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/rss_sliml'
end
