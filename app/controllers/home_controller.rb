class HomeController < ApplicationController
  def index
		if signed_in?
			@user = current_user
    	@todos = @user.todos.paginate(page: params[:page])
			@todo = current_user.todos.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end
end
