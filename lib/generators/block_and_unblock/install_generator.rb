require "rails/generators/active_record"

module BlockAndUnblock
	module Generators
		class InstallGenerator < Rails::Generators::Base
			include ActiveRecord::Generators::Migration

			source_root File.join(__dir__, "templates")

			def copy_migration
				migration_template "blocks_migration.rb", "db/migrate/create_blocks.rb", migration_version: migration_version
			end

			def create_model
				copy_file "block_model.rb", "app/models/block.rb"
			end
		
			def migration_version
				"[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
			end
		end
	end
end