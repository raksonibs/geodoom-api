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