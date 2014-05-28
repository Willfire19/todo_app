require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit users_path
    end

    # it { should have_selector('title',   text: 'All users') }
    it { should have_selector('h1',      text: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.username)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:todo, user: user, entry: "Michael Bolt") }
    let!(:m2) { FactoryGirl.create(:todo, user: user, entry: "David Givens") }

    before { visit user_path(user) }

    it { should have_selector('h1',     text: user.username) }
    it { should have_selector('title',  text: user.username) }

    describe "todos" do
      it { should have_content(m1.entry) }
      it { should have_content(m2.entry) }
      it { should have_content(user.todos.count) }
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before{ visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_xpath("//input[@value='Unfollow']") }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_selector('title', text: 'Sign Up') }

    let(:submit) { "Submit" }
    describe "with invalid information" do
    	it "should not create a user" do
    		expect { click_button submit }.not_to change(User, :count)
    	end
    end

    describe "with valid information" do
    	before do
    		fill_in "Username",			with: "Willfire19"
    		fill_in "Email",				with: "spnrd232@yahoo.com"
    		fill_in "Password",			with: "Password"
    		fill_in "Confirmation",	with: "Password"
    	end

    	it "should create a user" do
    		expect { click_button submit }.to change(User, :count).by(1)
    	end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('spnrd232@yahoo.com') }

        it { should have_selector('title', text: user.username) }
        # it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }
  	it { should have_selector('h1', text: user.username) }
  	it { should have_selector('title', text: user.username) }	
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',     text: "Update your Profile") }
      # it { should have_selector('title',  text: "Edit user") }
      it { should have_link('Change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Submit" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_username)    { "New Name" }
      let(:new_email)   { "new@example.com" }
      before do
        fill_in "Username",         with: new_username
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation",     with: user.password
        click_button "Submit"
      end

      it { should have_selector('title', text: new_username) }
      # it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.username.should == new_username }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.username, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.username, href: user_path(user)) }
    end
  end
end