module BlockAndUnblock
	module Controllers
		module BlockController
			delegate :current_user, to: :current_controller
			
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

			def block_user_params
				raise 'class responsability'
			end

			def unblock_user_params
				raise 'class responsability'
			end
		end
	end
end
