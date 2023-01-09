require 'rails_helper'
require 'rspec'
RSpec.describe BlockAndUnblock::Controllers::BlockController do

	describe BlockController, type: :controller do
		describe 'POST block' do
			let(:blocked_user) { create :user }
			let(:blocked_user_id) { blocked_user.id }
			let(:block_user_params) { { blocked_user_id: } }

			context 'when the params are correct' do
				include_context 'when using doorkeeper'

				it 'responds with an ok code' do
					post :block, params: block_user_params
					expect(response.status).to eq 204
				end
			end

			context 'when user tries to block himself' do
				include_context 'when using doorkeeper'
				let(:block_user_params) { { blocked_user_id: current_user.id } }

				it 'responds with an error code' do
					post :block, params: block_user_params
					expect(response.status).to eq 422
				end
			end

			context 'with empty blocked_user_id' do
				include_context 'when using doorkeeper'

				before { block_user_params[:blocked_user_id] = '' }

				it 'responds with an error' do
					post :block, params: block_user_params
					expect(response.status).to eq 422
				end
			end

			context 'without being authenticated' do
				it 'responds with a 401' do
					post :block, params: block_user_params
					expect(response.status).to eq 401
				end
			end
		end

		describe 'POST unblock' do
			let(:blocked_user) { create :user }
			let(:blocked_user_id) { blocked_user.id }
			let(:unblock_user_params) { { blocked_user_id: } }

			context 'when the params are correct' do
				include_context 'when using doorkeeper'

				before { create :block, blocker: current_user, blocked_user: }
				it 'responds with an ok code' do
					post :unblock, params: unblock_user_params
					expect(response.status).to eq 204
				end
			end

			context 'when user tries to unblock himself' do
				include_context 'when using doorkeeper'
				let(:unblock_user_params) { { blocked_user_id: current_user.id } }

				it 'responds with an error code' do
					post :unblock, params: unblock_user_params
					expect(response.status).to eq 422
				end
			end

			context 'with empty blocked_user_id' do
				include_context 'when using doorkeeper'

				before { unblock_user_params[:blocked_user_id] = '' }

				it 'responds with an not found error code' do
					post :unblock, params: unblock_user_params
					expect(response.status).to eq 404
				end
			end

			context 'without being authenticated' do
				it 'responds with a 401' do
					post :unblock, params: unblock_user_params
					expect(response.status).to eq 401
				end
			end
		end
	end

	describe EmptyController, type: :controller do
		describe 'Block with empty controller' do
			it 'responds with an error' do
				expect { post :block_user }.to raise_error BlockAndUnblock::Errors::MethodRequiredError
			end
		end
		
		describe 'Unblock with empty controller' do
			it 'responds with an error' do
				expect { post :unblock_user }.to raise_error BlockAndUnblock::Errors::MethodRequiredError
			end
		end
	end
end
