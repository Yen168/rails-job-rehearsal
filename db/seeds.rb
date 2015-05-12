# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "automation"

for i in 1..5

	create_account = User.create([email: "#{i}@#{i}.com", password: "#{i}" * 8, password_confirmation: "#{i}" * 8, name: "#{i}"])

	create_groups = for j in 1..10
                  		Group.create!([title: "Group no.#{j}", description: "seed no. #{j} group", user_id: "#{i}"])
                  		for k in 1..5
                    		Post.create!([group_id: "#{j}",content: "seed no. #{k} post", user_id: "#{i}"])
                  		end
                	end

end