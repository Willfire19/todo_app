require 'spec_helper'

describe "Todo pages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "todo creation" do
  	before { visit new_user_todo_path(user) }

  	describe "with invalid information" do

  		it "should not create a todo" do
  			expect { click_button 'Submit' }.not_to change(Todo, :count)
  		end

  		describe "error messages" do
  			before { click_button 'Submit' }
  			it { should have_content('error') }
  		end
  	end

  	describe "with valid information" do

  		before do
        fill_in 'Entry', with: "Lorem ipsum"
        select "2013", :from => "todo_assignedDate_1i"
        select "January", :from => "todo_assignedDate_2i"
        select "1", :from => "todo_assignedDate_3i"
        select "2013", :from => "todo_dueDate_1i"
        select "January", :from => "todo_dueDate_2i"
        select "1", :from => "todo_dueDate_3i"
        fill_in 'Difficulty', with: 1
        fill_in 'Priority', with: 1
      end

  		it "should create a todo" do
  			expect { click_button 'Submit' }.to change(Todo, :count).by(1)
  		end
  	end
  end

  describe "todo destruction" do
    before { FactoryGirl.create(:todo, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a todo" do
        expect { click_link "delete" }.to change(Todo, :count).by(-1)
      end
    end
  end
end
