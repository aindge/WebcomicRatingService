# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Comics added from Piaza discussion. Feel free to add more if you want

#Add Homestuck
comicsList = [{:name => "Homestuck", :author => "Andrew Hussie", :url => "http://www.mspaintadventures.com/?s=6", :synopsis => "A young boy plays a video game with some of his friends and learns that this game will decide the fate of not only his own universe, but perhaps all of reality", :genre => "fantasy"}]
#Add Paranatural
comicsList << {:name => "Paranatural", :author => "Zack Morrison", :url => "http://www.paranatural.net/index.php?id=1", :synopsis => "Max is a kid who just moved into a new town. When he arives at his new school he is quickly dragged into the supernatural world of fighting evil spirits", :genre => "supernatural"}
#Add Ava's Demon
comicsList << {:name => "Ava's Demon", :author => "Michelle Czajkowski", :url => "http://www.avasdemon.com/", :synopsis => "A girl 1000 years in the future is plagued with a demon with alterior motives", :genre => "supernatural, scifi"}
#Add Monster Pulse
comicsList << {:name => "Monster Pulse", :author => "Magnolia Porter", :url => "http://www.monster-pulse.com/index.php?id=2", :synopsis => "Bina Blum gets wrapped up in a world of secret organisations and spirits when a strange creature jumps through her body and causes her heart to become its own sentient creature", :genre => "supernatural"}
#Add Problem Sleuth
comicsList << [{:name => "Problem Sleuth", :author => "Andrew Hussie", :url => "http://www.mspaintadventures.com/?s=4", :synopsis => "Three detectives try to escape their office building, which they have all managed to be trapped in. Shenanigans ensue", :genre => "I don't even know how to catagorize this mess"}]

#Add comics to database
comicsList.each do |comic|
	Comic.create!(comic)
end

#Add User sysadmin to user database
usersList = [{:username => "sysadmin", :password => "thisIsVerySecret22", :email => "someone@example.com", admin: true}]
#Add User Kragmoor to user database
usersList << [{:username => "Kragmoor", :password => "hisnameisfish", :email => "Icolston@gmail.com", admin: false}]

usersList.each do |user|
	User.create!(user)
end
