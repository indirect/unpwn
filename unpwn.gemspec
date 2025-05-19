require_relative "./lib/unpwn/version"

Gem::Specification.new do |spec|
  spec.name          = "unpwn"
  spec.version       = Unpwn::VERSION
  spec.authors       = ["Andre Arko"]
  spec.email         = ["andre@arko.net"]

  spec.summary       = "Keeps passwords from being easily hackable."
  spec.description   = "Keeps passwords from being easily hackable."
  spec.homepage      = "https://github.com/indirect/unpwn"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "bloomer", "~> 1.0"
  spec.add_dependency "pwned", "~> 2.0"

  spec.add_development_dependency "bundler", ">= 1"
  spec.add_development_dependency "http", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
