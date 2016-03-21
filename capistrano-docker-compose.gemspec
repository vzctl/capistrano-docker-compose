# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "capistrano-docker-compose"
  spec.version       = "0.0.1"
  spec.authors       = ["aCandidMind"]
  spec.email         = ["opensource@candidminds.com"]

  spec.summary       = %q{Invoking docker-compose commands during deployment and on demand.}
  spec.description   = "Invoking docker-compose commands during deployment and on demand. Uses a flat directory " +
                       "approach (no shared/releases folder) to be able to simply specify service directories to " +
                       "build without injecting variables for the release date or switching symlinks."
  spec.homepage      = "https://github.com/aCandidMind/capistrano-docker-compose"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'capistrano', '>= 3.3.0'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
