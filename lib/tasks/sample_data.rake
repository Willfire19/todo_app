namespace :db  do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(username: "Example User",
								 email: "example@railstutorial.org",
								 password: "foobar",
								 password_confirmation: "foobar")
		admin.toggle!(:admin)
		
		99.times do |n|
			username = Faker::Internet.user_name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(username: username,
									 email: email,
									 password: password,
									 password_confirmation: password)
		end

		users = User.all(limit: 6)
		50.times do
			entry = Faker::Lorem.sentence(5)
			assignedDate = 01-01-2103
			users.each { |user| user.todos.create!(entry: entry, assignedDate: assignedDate) }
		end
	end	
end