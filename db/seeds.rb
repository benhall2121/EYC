# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

if User.find(:first, :conditions => ['email = ?', 'benhall2121@yahoo.com']).nil?
  puts 'No data was found in the USERS table so we are seeding it'
  user1 = User.create(:email => 'benhall2121@yahoo.com', :password => '212134', :password_confirmation => '212134')
end
