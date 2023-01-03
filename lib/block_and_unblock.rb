require 'rails'
require 'active_support/dependencies'
require 'block_and_unblock/version'
require 'block_and_unblock/engine'

module BlockAndUnblock
	module Controllers
		autoload :BlockController, 'block_and_unblock/controllers/block_controller'
	end

	module Errors
		autoload :UnprocessableError, 'block_and_unblock/errors/unprocessable_error'
	end

	module Interactors
		autoload :BlockUser, 'block_and_unblock/interactors/block_user'
		autoload :UnblockUser, 'block_and_unblock/interactors/unblock_user'
	end

	module Generators
		autoload :InstallGenerator, 'generators/block_and_unblock/install_generator.rb'
	end

end
