namespace :db do
	desc "Fill Database with fiigii"
	task :populate => :environment do
		make_users
		post_some
		retweets
		follow
		good_and_down
	end

	desc "Fill new Posts"
	task :add_new => :environment do
		user = User.find(1)
		10.times do |n|
			content = Faker::Lorem.sentence(5) * 20
			user.statuses.create!(content: content)
		end
	end
end

def make_users
	99.times do |n|
		name = Faker::Name.name
		email = "email_#{n + 1}@gmail.com"
		password = "123456"
		descript = "I am a Faker!"
		gender = "m"
		url = "#{name.split.join("_")}.fiigii.com"
		User.create!(name: name,
			email: email,
			descript: descript,
			gender: gender,
			url: url,
			password: password,
			password_confirmation: password,)
	end
end

def post_some
	users = User.all
	users.each do |user|
		25.times do |n|
			content = Faker::Lorem.sentence(5) * 20
			user.statuses.create!(content: content)
		end
	end
end

def add_new_post
	users = User.all
		users.each do |user|
			2.times do |n|
				content = "New Post."
				user.statuses.create!(content: content, 
				retweeted_id: 1)
			end
		end
end

def retweets
	retweeteds = Status.all(limit: 20)
	users = User.all(limit: 10)
	users.each do |user|
		25.times do |n|
			content = Faker::Lorem.sentence(5)
			user.statuses.create!(content: content, 
				retweeted_id: retweeteds.shuffle.first.id)
		end
	end
end

def follow
	users = User.all
	user = users.first
	followed_users = users[2..80]
	followers = users[3..77]
	followed_users.each { |u| user.follow! u }
	followers.each { |u| u.follow! user }
end

def good_and_down
	users = User.all(limit: 50)
	status = Status.first
	users.each do |user|
		status.good! users
		status.bad! users
	end
end