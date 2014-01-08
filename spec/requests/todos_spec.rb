require 'spec_helper'


describe "Todos" do

  let(:user) { FactoryGirl.create(:user) }
  let(:list) { FactoryGirl.create(:list, user: user) }
  before { @todo = user.todos.build(entry: "Lorem ipsum", assignedDate: DateTime.new(2013, 1, 1),
                                    dueDate: DateTime.new(2013, 2, 1), difficulty: 1, priority: 1,
                                    tag: "test"
                                    ) }

  subject { @todo }

  it { should respond_to(:entry) }
  it { should respond_to(:user_id) }
  it { should respond_to(:list_id) }
  it { should respond_to(:user) }
  it { should respond_to(:assignedDate) }
  it { should respond_to(:dueDate) }
  it { should respond_to(:status) }
  it { should respond_to(:difficulty) }
  it { should respond_to(:priority) }
  it { should respond_to(:tag) }
  its(:user) { should == user }
  its(:status) { should == "To Do" }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Todo.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  # describe "when user_id is not present" do
  #   before { @todo.user_id = nil }
  #   it { should be_valid }
  # end

  describe "with blank content" do
    before { @todo.entry = " " }
    it {should_not be_valid }
  end

  describe "with content that is too long" do
    before { @todo.entry = "a" * 257 }
    it { should_not be_valid }
  end

  describe "with content that is acceptable" do
    before { @todo.entry = "a" * 255 }
    it { should be_valid }
  end

  describe "list" do

    describe "id is not present" do
      before { @todo.list_id = nil }
      it { should be_valid }
    end

    describe "id is present" do
      before { @todo.list_id = list }
      it { should be_valid }
    end

    describe "id is present" do
      before { @todo2 = user.todos.build(entry: "Lorem ipsum", assignedDate: DateTime.new(2013, 1, 1),
                                    dueDate: DateTime.new(2013, 2, 1), difficulty: 1, priority: 1,
                                    tag: "test", list_id: list
                                    ) }
      it { should be_valid }
    end
    
  end

  describe "assigned date" do

    describe "can be empty on creation" do
      before { @todo.assignedDate = nil }
      it { should be_valid }
    end

  end

  describe "due date" do

    describe "can be empty on creation" do
      before { @todo.dueDate = nil }
      it { should be_valid }
    end

  end

  describe "tag" do

    describe "can be empty on creation" do
      before { @todo.tag = "" }
      it { should be_valid }
    end
  end

  describe "priority" do

    describe "should not be over 11" do
      before { @todo.priority = 12 }
      it { should_not be_valid }
    end

    describe "can be less then 1" do
      before { @todo.priority = 0 }
      it { should be_valid }
    end

    describe "should be 0 as default" do
       before do
        @todo4 = user.todos.build(entry: "Lorem ipsum", assignedDate: 01-01-2013,
                                 dueDate: 01-02-2013, difficulty: 1, priority: nil,
                                 status: "To Do")
        @todo4.save
      end
      subject { @todo4 }

      its(:priority) { should == 0 }
    end

  end

  describe "difficulty" do

    describe "can be less than 1" do
      before { @todo.difficulty = 0 }
      it { should be_valid }
    end

    describe "should not be greater than 100" do
      before { @todo.difficulty = 101 }
      it { should_not be_valid }
    end

    describe "should be 0 as default" do
      before do
        @todo3 = user.todos.build(entry: "Lorem ipsum", assignedDate: 01-01-2013,
                                 dueDate: 01-02-2013, difficulty: nil, priority: 1,
                                 status: "To Do")
        @todo3.save
      end
      subject { @todo3 }

      its(:difficulty) { should == 0 }
    end

  end

  describe "status" do 
    describe "should be To Do as default" do
      before { @todo.save }
      its(:status) { should == "To Do" }
    end

    describe "should not be empty" do
      before { @todo.status = " " }
      it { should_not be_valid }
    end

    describe "can be 'In Progress' on create" do
      before do
        @todo1 = user.todos.build(entry: "Lorem ipsum", assignedDate: 01-01-2013,
                                 dueDate: 01-02-2013, difficulty: 1, priority: 1,
                                 status: "In Progress")
        @todo1.save
      end

      subject { @todo1 }

      its(:status) { should == "In Progress" }
    end

    describe "should not be 'Complete!' on create" do
      before do
        @todo2 = user.todos.build(entry: "Lorem ipsum", assignedDate: 01-01-2013,
                                 dueDate: 01-02-2013, difficulty: 1, priority: 1,
                                 status: "Complete!")
        @todo2.save
      end

      subject { @todo2 }

      its(:status) { should == "To Do" }
    end
  end
end
