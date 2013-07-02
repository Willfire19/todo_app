class TodosController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  # GET /todos
  # GET /todos.json
  def index
    @user = User.find_by_id(params[:user_id])
    @todos = @user.todos.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])
    @todo.user = User.find_by_id(params[:user_id])
    @user = @todo.user
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @user = current_user
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
    @todo.user = User.find_by_id(params[:user_id])
    @user = @todo.user
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = current_user.todos.build(params[:todo])
    @todo.user = current_user
    @user = @todo.user
    respond_to do |format|
      if @todo.save
        #format.html { redirect_to user_todo_path(@user, @todo), notice: 'Todo was successfully created.' }
        format.html { redirect_to user_todo_path(@user, @todo), notice: 'Todo was successfully created!' }
        format.json { render json: @user, status: :created, location: @user }
      else
        @feed_items = []
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to user_todo_path, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy

    @user = current_user
    @todo.user = @user
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private

    def correct_user
      @todo = current_user.todos.find_by_id(params[:id])
      redirect_to root_url if @todo.nil?
    end
end
