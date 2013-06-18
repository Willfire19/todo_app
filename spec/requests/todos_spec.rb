require 'spec_helper'


describe "Todos" do

  let(:user) { FactoryGirl.create(:user) }
  before { @todo = user.todos.build(entry: "Lorem ipsum", assignedDate: 01-01-2013) }

  subject { @todo }

  it { should respond_to(:entry) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attrrbutes" do
    it "should not allow access to user_id" do
      expect do
        Todo.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "when user_id is not present" do
    before { @todo.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @todo.entry = " " }
    it {should_not be_valid }
  end

  describe "with content that is too long" do
    before { @todo.entry = "a" * 141 }
    it { should_not be_valid }
  end
end
