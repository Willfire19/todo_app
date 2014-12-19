class HomeController < ApplicationController
  def index
		if signed_in?
			@user = current_user
    	@todos = @user.todos.paginate(page: params[:page])
    	@lists = @user.lists
			@todo = current_user.todos.build
			@list = current_user.lists.build
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end
end
