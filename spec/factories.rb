FactoryGirl.define  do
	factory :user do
		sequence(:username) { |n| "Person #{n}" }
		sequence(:email) 	{ |n| "person_#{n}@example.com" }
		password			"password"
		password_confirmation "password"

		factory :admin do
			admin true
		end
	end

	factory :list do
		name "All"
		user
	end

	factory :todo do
		entry "Lorem ipsum"
		list
		assignedDate DateTime.new(2013, 1, 1)
		dueDate DateTime.new(2013, 1, 1)
		status "To Do"
		difficulty 1
		priority 1 
	end
end