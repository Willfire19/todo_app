require 'spec_helper'

describe "Todo pages" do
  
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:list) { FactoryGirl.create(:list, user: user)}
  before { sign_in user }

  describe "todo creation" do
  	before { visit new_user_todo_path(user) }

  	describe "with invalid information" do

      before do
        fill_in 'Entry', with: ""
        select "2013", :from => "todo_assignedDate_1i"
        select "January", :from => "todo_assignedDate_2i"
        select "1", :from => "todo_assignedDate_3i"
        select "2013", :from => "todo_dueDate_1i"
        select "January", :from => "todo_dueDate_2i"
        select "1", :from => "todo_dueDate_3i"
        fill_in 'Difficulty', with: 1
        fill_in 'Priority', with: 1
        # fill_in 'Tag', with: "David Givens"
        select "Uncategorized", :from => "List"
      end

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
        fill_in 'Entry', with: "Michael Bolt"
        select "2013", :from => "todo_assignedDate_1i"
        select "January", :from => "todo_assignedDate_2i"
        select "1", :from => "todo_assignedDate_3i"
        select "2013", :from => "todo_dueDate_1i"
        select "January", :from => "todo_dueDate_2i"
        select "1", :from => "todo_dueDate_3i"
        fill_in 'Difficulty', with: 1
        fill_in 'Priority', with: 1
        # fill_in 'Tag', with: "David Givens"
        select "In Progress", :from => "todo_status"
        select "Uncategorized", :from => "List"
      end

  		it "should create a todo" do
  			expect { click_button 'Submit' }.to change(Todo, :count).by(1)
  		end

      describe "should direct to the home page" do
        # it { should have_selector('title', text: 'TodoRaider | Home') }
         # it { should have_selector('h1', text: user.username) }
      end

  	end
  end

  describe "todo edit" do
    let(:todo1) { FactoryGirl.create(:todo, user: user, list: list) }
    
    before { visit edit_user_todo_path( user, todo1 ) }

    describe "with valid information" do

      before do
        fill_in 'Entry', with: "Jamar Sweeley"
        select "2013", :from => "todo_assignedDate_1i"
        select "January", :from => "todo_assignedDate_2i"
        select "1", :from => "todo_assignedDate_3i"
        select "2013", :from => "todo_dueDate_1i"
        select "January", :from => "todo_dueDate_2i"
        select "1", :from => "todo_dueDate_3i"
        fill_in 'Difficulty', with: 1
        fill_in 'Priority', with: 1
        select "In Progress", :from => "todo_status"
        # fill_in 'Tag', with: "Devin Cobb"
        select "Uncategorized", :from => "List"
        click_button "Submit"
      end

      # it { should have_selector('div.alert.alert-success') }

      # describe "should direct to home page" do
      #   it { should have_selector('title', text: 'TodoRaider | Home') }
      # end

    end

    describe "with invalid information" do

      before do
        fill_in 'Entry', with: ""
        select "2013", :from => "todo_assignedDate_1i"
        select "January", :from => "todo_assignedDate_2i"
        select "1", :from => "todo_assignedDate_3i"
        select "2013", :from => "todo_dueDate_1i"
        select "January", :from => "todo_dueDate_2i"
        select "1", :from => "todo_dueDate_3i"
        fill_in 'Difficulty', with: 1
        fill_in 'Priority', with: 1
        select "In Progress", :from => "todo_status"
        # fill_in 'Tag', with: "J.R Meyers"
        select "Uncategorized", :from => "List"
        click_button "Submit"
      end

      it { should have_content('error') }
      it { should have_select('todo_status') }
    end
  end

  describe "todo destruction" do
    before { FactoryGirl.create(:todo, user: user, list: list) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a todo" do
        expect { click_link "Delete" }.to change(Todo, :count).by(-1)
      end
    end

    describe "on the todo index page" do
      before{ visit user_todos_path(user) }

      it "should delete a todo" do
        expect { click_link "Destroy" }.to change(Todo, :count).by(-1)
      end

      describe "should redirect back to todo index" do
        before :js => true do 
          click_link "Destroy"
          page.driver.browser.switch_to.alert.accept
        end

        # it { should have_selector('title', text: 'TodoRaider | Todos') }
      end
    end
  end
end
 