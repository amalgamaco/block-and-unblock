require 'rails_helper'

RSpec.shared_examples 'Unblock user is successful' do
	it 'deletes an existing block' do
		expect { call_interactor }.to change(Block, :count).by(-1)
	end

	it 'deletes the block with the passed users' do
		expect(call_interactor).to have_attributes(blocked_user_id:, blocker_id: current_user.id)
	end
end

RSpec.describe BlockAndUnblock::Interactors::UnblockUser do
	let(:current_user) { create :user }
	let(:blocked_user) { create :user }
	let(:blocked_user_id) { blocked_user.id }
	let(:block_relation_klass_name) { 'block' }
	let(:blocker_user_id) { current_user.id }

	let(:call_interactor) { described_class.with(current_user:, blocked_user_id:, block_relation_klass_name:) }

	context 'with correct params' do
		before { create :block, blocker: current_user, blocked_user: }

		include_examples 'Unblock user is successful'
	end

	context 'when the user and the blocked user are the same' do
		let(:blocked_user) { current_user }

		include_examples 'raises Error exception', BlockAndUnblock::Errors::UnprocessableError
	end

	context 'when the blocked user is not blocked' do

		include_examples 'raises Error exception', ActiveRecord::RecordNotFound
	end
end
