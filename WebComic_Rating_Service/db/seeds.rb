# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#Comics added from Piaza discussion. Feel free to add more if you want

#Add Homestuck
comicsList = [{:name => "Homestuck", :author => "Andrew Hussie", :url => "http://www.mspaintadventures.com/?s=6", :synopsis => "A young boy plays a video game with some of his friends and learns that this game will decide the fate of not only his own universe, but perhaps all of reality", :genre => "fantasy", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]
#Add Paranatural
comicsList << [{:name => "Paranatural", :author => "Zack Morrison", :url => "http://www.paranatural.net/index.php?id=1", :synopsis => "Max is a kid who just moved into a new town. When he arives at his new school he is quickly dragged into the supernatural world of fighting evil spirits", :genre => "supernatural", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]
#Add Ava's Demon
comicsList << [{:name => "Ava's Demon", :author => "Michelle Czajkowski", :url => "http://www.avasdemon.com/", :synopsis => "A girl 1000 years in the future is plagued with a demon with alterior motives", :genre => "supernatural, scifi", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]
#Add Monster Pulse
comicsList << [{:name => "Monster Pulse", :author => "Magnolia Porter", :url => "http://www.monster-pulse.com/index.php?id=2", :synopsis => "Bina Blum gets wrapped up in a world of secret organisations and spirits when a strange creature jumps through her body and causes her heart to become its own sentient creature", :genre => "supernatural", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]
#Add Problem Sleuth
comicsList << [{:name => "Problem Sleuth", :author => "Andrew Hussie", :url => "http://www.mspaintadventures.com/?s=4", :synopsis => "Three detectives try to escape their office building, which they have all managed to be trapped in. Shenanigans ensue", :genre => "Comedy", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]
#Add Stand Still, Stay Silent
comicsList << [{:name => "Stand Still, Stay Silent", :author => "Minna Sundberg", :url => "http://www.sssscomic.com/", :synopsis => "It's been 90 years after the end of the old world. But now, at last, it is time to send out an research crew into the great unknown! A poorly funded and terribly unqualified crew, but a crew nonetheless.", :genre => "post-apocalyptic", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]
#Add Gunnerkrigg Court
comicsList << [{:name => "Gunnerkrigg Court", :author => "Tom Siddell", :url => "http://www.gunnerkrigg.com/", :synopsis => "\"My name is Antimony Carver. I would like to share with you the strange events that took place while I attended school at Gunnerkrigg Court.\"", :genre => "scifi, fantasy, school", :rating_art => 0, :rating_story => 0, :rating_overall => 0, :rates => 0}]

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
