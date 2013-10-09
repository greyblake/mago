require File.expand_path('../lib/mago/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "mago"
  gem.version     = Mago::VERSION
  gem.authors     = [ "Sergey Potapov" ]
  gem.email       = [ "blake131313@gmail.com" ]
  gem.summary     = "Tool to detect magic numbers in ruby code"
  gem.description = "Provides a command and API to detect magic numbers in ruby code"
  gem.homepage    = "https://github.com/greyblake/mago"
  gem.license     = 'MIT'

  gem.require_paths    = [ "lib" ]
  gem.executables      = ['mago']
  gem.files            = Dir['./lib/**/*.rb'] + Dir['./bin/*']
  gem.test_files       = Dir['./spec/**/*.rb']
  gem.extra_rdoc_files = %w[LICENSE.txt README.markdown]

  gem.add_dependency('ruby_parser')
  gem.add_dependency('sexp_processor')
end
