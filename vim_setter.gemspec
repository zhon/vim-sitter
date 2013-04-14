# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "vim-sitter"
  spec.version       = VimSitter::VERSION
  spec.authors       = ["zhon"]
  spec.email         = ["zhon@xputah.org"]
  spec.description   = %q{vim-sitter will install/remove plugins; setup directories; and help you manage your vim settings}
  spec.summary       = %q{Helping you manage your settings}
  spec.homepage      = "https://github.com/zhon/vim-sitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "flexmock"
end
