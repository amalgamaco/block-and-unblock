##Block and Unblock

This gem provides a controller, two interactors and a generator for block model and migration to implement the block and unblock functionality.

To add this gem to your project, copy this into your gemfile:

```ruby
	gem 'block_and_unblock', git: 'https://github.com/amalgamaco/block-and-unblock.git'
```

Then, execute `bundle install`.

After that, you can generate the migration and the model with the following command:

```shell
	rails generate block_and_unblock:install 
```
It generates a block migration in `db/migrate` and a block model in `app/models`. You can modify those files if you want to! 

Then you can move foward and define a controller like this, which includes the BlockController provided by this gem:
```ruby
class BlockController < ApplicationController
	include BlockAndUnblock::Controllers::BlockController

	rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_error
	rescue_from BlockAndUnblock::Errors::UnprocessableError, with: :render_invalid_error
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
	
	before_action :doorkeeper_authorize!

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
```
The `block_relation_class_name` represents the name of your block class. If you created a block class with a different name or if you changed the one given by te install generator then you must change the `block_relation_class_name` to match your class.

Also you will need to define the routes, for this example they will look like this:

```ruby
	post 'users/:blocked_user_id/block' => 'block#block'
	post 'users/:blocked_user_id/unblock' => 'block#unblock'
```

And now your block and unblock functionality is fully implemented! 
