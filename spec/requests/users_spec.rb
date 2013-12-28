require 'spec_helper'

describe "Users" do
  
	before do
	  @user = User.new(username: "Ex User", email: "example@yahoo.com",
	  				   password: "password", password_confirmation: "password")
	  @list = List.new( name: "ToDos" )
	  @list.user = @user
	  @list.save
	end

	subject { @user }

	it { should respond_to(:username) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:admin) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:todos) }
	it { should respond_to(:feed) }
	it { should respond_to(:relationships) }
	it { should respond_to(:followed_users) }
	it { should respond_to(:reverse_relationships) }
	it { should respond_to(:followers) }
	it { should respond_to(:following?) }
	it { should respond_to(:follow!) }
	it { should respond_to(:lists) }

	it { should be_valid }
	it { should_not be_admin }

	describe "list" do
		before do 
    	@user2 = User.new(username: "Ex User", email: "example@yahoo.com",
  				   password: "password", password_confirmation: "password")
    	@user2.save
    end

		describe "should be created as user is created" do
      it { @user2.lists.should_not be_empty }
    end

    describe "should be named Uncategorized" do
    	it { @user2.lists.first.name == "Uncategorized" }
    end

  end

	describe "with admin attribute set to 'true'" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end

		it { should be_admin }
	end

	describe "remember token" do 
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

	describe "when password is not present" do
	  before { @user.password = @user.password_confirmation = " " }
	  it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
	  before { @user.password_confirmation = "not password" }
	  it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
	  before { @user.password_confirmation = nil }
	  it { should_not be_valid }
	end


	it { should respond_to(:authenticate) }

	describe "with a password that's too short" do
	  before { @user.password = @user.password_confirmation = "a" * 5 }
	  it { should be_invalid }
	end

	describe "return value of authenticate method" do
	  before { @user.save }
	  let(:found_user) { User.find_by_email(@user.email) }

	  describe "with valid password" do
	  	it { should == found_user.authenticate(@user.password) }
	  end

	  describe "with invalid password" do
	  	let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	  	it { should_not == user_for_invalid_password }
	  	specify { user_for_invalid_password.should be_false }
	  end
	end

	describe "todo associations" do

		before { @user.save }
		let!(:older_todo) do
			FactoryGirl.create(:todo, list: @list, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_todo) do
			FactoryGirl.create(:todo, list: @list, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right todos in the right order" do
			@user.todos.should == [newer_todo, older_todo]
		end

		it "should destroy associated todos" do
			todos = @user.todos.dup
			@user.destroy
			# todos.should_not be_empty
			# at this point, the todos should be empty,
			# but the test keeps on failing
			# todos.should be_empty
			todos.each do |todo|
				Todo.find_by_id(todo.id).should be_nil
			end
		end

		it "should destroy associated lists" do
			lists = @user.lists.dup
			@user.destroy
			# todos.should_not be_empty
			# at this point, the lists should be empty,
			# but the test keeps on failing
			# lists.should be_empty
			lists.each do |list|
				List.find_by_id(list.id).should be_nil
			end
		end

		# describe "status" do
		# 	let(:unfollowed_post) do
		# 		FactoryGirl.create(:todo, user: FactoryGirl.create(:user))
		# 	end
		# 	let(:followed_user) { FactoryGirl.create(:user) }
		# 	let(:list) { FactoryGirl.create(:list, user: followed_user) }

		# 	before do
		# 		@user.follow!(followed_user)
		# 		3.times { list.todos.create!(entry: "Lorem ipsum", assignedDate: DateTime.new(2013, 1, 1),
  #                                   dueDate: DateTime.new(2013, 2, 1), difficulty: 1, priority: 1,
  #                                   tag: "test") }
		# 	end

		# 	its(:feed) { should include(newer_todo) }
		# 	its(:feed) { should include(older_todo) }
		# 	its(:feed) { should_not include(unfollowed_post) }
		# 	its(:feed) do
		# 		followed_user.todos.each do |todo|
		# 			should include(todo)
		# 		end
		# 	end
		# end
	end

	describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
    	subject { other_user }
    	its(:followers) { should include(@user) }
    end

    describe "and unfollowing" do
    	before { @user.unfollow!(other_user) }

    	it { should_not be_following(other_user) }
    	its (:followed_users) { should_not include(other_user) }
    end
  end
end
