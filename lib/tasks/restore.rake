desc "restore pet states"
task :restore => :environment do 
  PetState.all.each do |ps|
    stats = ps.pet.stats.map(&:value)
    ps.update_attributes(current_health: stats[0], current_attack: stats[1], current_defence: stats[2])    
  end
end

desc "restore pet states to 100 heal"
task :health_max => :environment do 
  PetState.all.each do |ps|    
    ps.update_attributes(current_health: 100)
  end
end