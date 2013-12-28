class ListsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  # GET /todos
  # GET /todos.json
  # def index
  #   @user = User.find_by_id(params[:user_id])
  #   @todos = @user.todos.paginate(page: params[:page])

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @todos }
  #   end
  # end

  # GET /todos/1
  # GET /todos/1.json
  # def show
  #   @todo = Todo.find(params[:id])
  #   @todo.user = User.find_by_id(params[:user_id])
  #   @user = @todo.user
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @todo }
  #   end
  # end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @user = current_user
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    @list.user = User.find_by_id(params[:user_id])
    @user = @list.user
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = current_user.lists.build(params[:todo])
    @list.user = current_user
    @user = @list.user
    respond_to do |format|
      if @list.save
        
        format.html { redirect_to root_path, notice: 'List was successfully created!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        @feed_items = []
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list = List.find(params[:id])
    @list.user = current_user
    @user = @list.user

    respond_to do |format|
      if @list.update_attributes(params[:todo])
        format.html { redirect_to root_path, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy

    @user = current_user
    @list.user = @user
    @list.destroy

    respond_to do |format|
      #format.html { redirect_to root_url }
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
