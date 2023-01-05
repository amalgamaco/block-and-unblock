class EmptyController < ApplicationController
	skip_before_action :doorkeeper_authorize!

	include BlockAndUnblock::Controllers::BlockController
end
