# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Forum.delete_all
Message.delete_all

forum = Forum.create(:title => 'filled forum')
1000.times do
  forum.messages.create :name => nil, :email => '', :body => 'hoge'
end
