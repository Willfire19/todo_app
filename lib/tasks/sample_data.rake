namespace :db  do
	desc "Fill database with sample data"
	task populate: :environment do

		make_users
		make_todos
		make_relationships
	end
end

def make_users
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
end

def make_todos
	users = User.all(limit: 6)
	50.times do
		entry = Faker::Lorem.sentence(5)
		assignedDate = DateTime.new(2013, 1, 1)
		dueDate = DateTime.new(2013, 1, 1)
		difficulty = 1
		priority = 1
		users.each { |user| user.todos.create!(entry: entry, assignedDate: assignedDate,
								 dueDate: dueDate, difficulty: difficulty, priority: priority ) }
	end	
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers 		 = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each			{ |follower| follower.follow!(user) }
end
