# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["User", "Admin"].each do |name|
  Role.find_or_create_by_name name
end

50.times do |n|
  login = Faker::Name.last_name

  user = User.new(:login => login, :email => "#{login}@mail.ru", :password => "123456")
  next unless user.save!
end

User.create!(:login => "DAS", :email => "das@mail.ru", :password => "123456")
