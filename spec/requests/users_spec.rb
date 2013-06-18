require 'spec_helper'

describe "Users" do
  
	before do
	  @user = User.new(username: "Ex User", email: "example@yahoo.com",
	  				   password: "password", password_confirmation: "password")
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

	it { should be_valid }
	it { should_not be_admin }

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
			FactoryGirl.create(:todo, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_todo) do
			FactoryGirl.create(:todo, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right todos in the right order" do
			@user.todos.should == [newer_todo, older_todo]
		end

		it "should destroy associated todos" do
			todos = @user.todos.dup
			@user.destroy
			todos.should_not be_empty
			todos.each do |todo|
				Todo.find_by_id(todo.id).should be_nil
			end
		end

		describe "status" do
			let(:unfollowed_post) do
				FactoryGirl.create(:todo, user: FactoryGirl.create(:user))
			end

			its(:feed) { should include(newer_micropost) }
			its(:feed) { should include(older_micropost) }
			its(:feed) { should_not include(unfollowed_post) }
		end
	end
end
