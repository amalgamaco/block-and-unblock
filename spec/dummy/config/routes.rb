Rails.application.routes.draw do
	use_doorkeeper :scope => 'v1/oauth' do
		skip_controllers :authorizations, :applications, :authorized_applications
	end

	devise_for :users, skip: [:confirmations, :registrations, :unlocks]

	devise_scope :users do
		post 'users/:blocked_user_id/block' => 'block#block'
		post 'users/:blocked_user_id/unblock' => 'block#unblock'
	end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
