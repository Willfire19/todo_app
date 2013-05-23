require 'spec_helper'


describe "Todos" do

  before :each do
    @todo = Todo.new( :assignedDate => 2013-01-02, :entry => "Do All The Tests!", :user_id => 1)
    	#, Willfire19, Willfire19
    #@todo.save
  end

  describe "GET /todos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get todos_path
      response.status.should be(200)
    end
  end

  describe "when a to do is not created by anyone" do
  	before { @todo.user_id = nil }
  	it {@todo.should_not be_valid}
  end

  describe "when a to do is not assigned to by anyone" do
  	before { @todo.assignedTo = nil }
  	it {@todo.should_not be_valid}
  end
end
