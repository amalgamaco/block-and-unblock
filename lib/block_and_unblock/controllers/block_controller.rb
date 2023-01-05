module BlockAndUnblock
	module Controllers
		module BlockController
			
			include BlockAndUnblock::Errors

			REQUIRED_METHODS = [ :current_user, :block_user_params, :unblock_user_params ]


			def block_user
				BlockAndUnblock::Interactors::BlockUser.with(
					current_user:,
					blocked_user_id: block_user_params[:blocked_user_id],
					block_relation_klass_name: block_user_params[:block_relation_klass_name]
				)
			end

			def unblock_user
				BlockAndUnblock::Interactors::UnblockUser.with(
					current_user:,
					blocked_user_id: block_user_params[:blocked_user_id],
					block_relation_klass_name: block_user_params[:block_relation_klass_name]
				)
			end

private

			def method_missing(method, *args, &block)
				raise MethodRequiredError.new(method, self.class) if REQUIRED_METHODS.include? method
				super
			end
		end
	end
end
