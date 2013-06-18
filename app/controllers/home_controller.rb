class HomeController < ApplicationController
  def index
		if signed_in?
			@todo = current_user.todos.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end
end
