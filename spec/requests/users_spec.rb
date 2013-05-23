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

	it { should be_valid }

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



  describe "GET /users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_index_path
      response.status.should be(200)
    end
  end


end
