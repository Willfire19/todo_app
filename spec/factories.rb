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

	factory :todo do
		entry "Lorem ipsum"
		user
		assignedDate 01-01-2013
	end
end