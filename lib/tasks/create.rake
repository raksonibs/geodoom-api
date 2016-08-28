require 'faker'

desc "Create some battles"
task :create_battles => :environment do   
  battle = Battle.last
  101.times do |i|
    if i.even?
      winner = User.find(1)
      loser = User.find(2)
    else
      winner = User.find(2)
      loser = User.find(1)
    end
    
    new_battle = Battle.create(winner_id: winner.id, loser_id: loser.id, challenged_email: winner.email, challenger_email: loser.email, status: 2, challenger_pet_id: 21, challenged_pet_id: 26)
  end
end

desc "Create some game states from counter strike, would be crontask?"
task :create_gs => :environment do   
  user = User.where(uid: ENV["user_id"], email: "oskar@gmail.com").first
  
  url = URI.parse('http://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?appid=730&key=BE84B16B9FDDAC9CEAD6A7CD5915638C&steamid=76561198077942014')
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }

  json = JSON.parse(res.body)  
  json['playerstats']["stats"].each{|stat| GameStat.find_by_user_id_and_name(user.id, stat["name"]) || GameStat.create!(user_id: user.id, name: stat["name"], value: stat["value"])}
end

desc 'Create Items'
task :create_items => :environment do 
  10000.times do |i|
    name = Faker::Name.name 
    defenceChange = rand*100
    attackChange = rand*100

    Item.create(name: name, defenceChange: defenceChange, attackChange: attackChange)
  end
end