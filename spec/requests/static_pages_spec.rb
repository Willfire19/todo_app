require 'spec_helper'

describe "Static pages"  do

	subject { page }

	describe "Home page" do

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:todo, user: user, entry: "Lorem ipsum")
				FactoryGirl.create(:todo, user: user, entry: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it { should have_link("Add a New List!", href: new_user_list_path(user)) }

			# it "should render the user's feed" do
			# 	user.feed.each do |item|
			# 		page.should have_selector("li##{item.id}", text: item.entry)
			# 	end
			# end

			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }
			end
		end
	end

	describe "Contact Page" do

		before { visit contact_path }

		it { should have_selector('h1', text: 'Contact') }
		it { should have_selector('title', text: 'Contact') }

	end

	describe "About Page" do

		before { visit about_path}

		it { should have_selector('h1', text: 'About') }
		it { should have_selector('title', text: 'About') }

	end

	describe "Version Page" do

		before { visit version_path }

		it { should have_selector('h1', text: 'Version') }
		it { should have_selector('title', text: 'Version') }

	end	
end