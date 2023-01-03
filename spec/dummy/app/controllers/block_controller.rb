class BlockController < ApplicationController
	include BlockAndUnblock::Controllers::BlockController
	rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_error
	rescue_from BlockAndUnblock::Errors::UnprocessableError, with: :render_invalid_error
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
	before_action :doorkeeper_authorize!
	skip_before_action :doorkeeper_authorize!, only: %i[sign_up forgot_password forgot_pass reset_password current_user]

	def render_invalid_error
		render(status: '422')
	end

	def render_not_found
		render(status: '404')
	end

	def block
		block_user
	end

	def unblock
		unblock_user
	end

private

	def current_user
		User.find doorkeeper_token.resource_owner_id rescue nil if doorkeeper_token
	end

	def block_user_params
		{ blocked_user_id: params[:blocked_user_id], block_relation_klass_name: 'block' }
	end

	def unblock_user_params
		{ blocked_user_id: params[:blocked_user_id], block_relation_klass_name: 'block' }
	end
end
