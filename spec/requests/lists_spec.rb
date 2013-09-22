require 'spec_helper'

describe "List" do
  
	let(:user) { FactoryGirl.create(:user) }
  before { @list = user.lists.build( name: "ToDos" ) }
  
  subject { @list }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        List.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "with no name"do
  	before { @list.name = "" }
  	it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @list.name = "a" * 26 }
    it { should_not be_valid }
  end

  describe "with name that is acceptable" do
    before { @list.name = "a" * 25 }
    it { should be_valid }
  end

  describe "user" do

  	describe "id is not present" do
  		before { @list.user_id = nil }
  		it { should_not be_valid }
  	end
  end

end
