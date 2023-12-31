require_relative 'lib/block_and_unblock/version'

Gem::Specification.new do |spec|
	spec.name        = 'block_and_unblock'
	spec.version     = BlockAndUnblock::VERSION
	spec.authors     = ['luca']
	spec.email       = ['lucagiabbani@amalgama.co']
	spec.homepage    = 'https://github.com/amalgamaco/block-and-unblock'
	spec.summary     = 'Summary of BlockAndUnblock.'
	spec.description = 'Description of BlockAndUnblock.'

	# Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
	# to allow pushing to a single host or delete this section to allow pushing to any host.
	spec.metadata['allowed_push_host'] = 'TODO: Set to http://mygemserver.com'

	spec.metadata['homepage_uri'] = spec.homepage
	spec.metadata['source_code_uri'] = 'https://github.com/amalgamaco/block-and-unblock'
	spec.metadata['changelog_uri'] = 'https://github.com/amalgamaco/block-and-unblock'

	spec.files = Dir.chdir(File.expand_path(__dir__)) do
		Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
	end

	spec.add_dependency 'rails', '>= 7.0.3.1'
	spec.add_dependency 'rake'
	spec.add_dependency 'rspec'
	spec.add_dependency 'rspec-rails'
	spec.add_dependency 'bundler'
	spec.add_dependency 'openssl'

	spec.add_dependency('railties', '>= 5.2.0') # encrypted credentials
	spec.add_development_dependency 'test-unit-rails'
	spec.add_development_dependency 'rubocop-rails'
	spec.add_development_dependency 'byebug'
	spec.add_development_dependency 'factory_bot_rails'
	spec.add_development_dependency 'shoulda-matchers'

	spec.add_development_dependency 'doorkeeper'
	spec.add_development_dependency 'config'
	spec.add_development_dependency 'devise'
end
