require_relative 'lib/cart/version'

Gem::Specification.new do |spec|
  spec.name          = "cart"
  spec.version       = Cart::VERSION
  spec.authors       = ["Ismail Akram"]
  spec.email         = ["ismail.akram@influitive.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/rubyonrails3/cart"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = 'https://github.com/rubyonrails3/cart'
  spec.metadata["source_code_uri"] = "https://github.com/rubyonrails3/cart"
  spec.metadata["changelog_uri"] = "https://github.com/rubyonrails3/cart"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
