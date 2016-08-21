# Doorkeeper::Application.destroy_all
# Doorkeeper::Application.create(name: "rg_web", redirect_uri: "http://localhost:3000/")

Pet.destroy_all
Battle.destroy_all

user = User.create(email: 'oskar@gmail.com')
user_1 = User.create(email: 'kacper@gmail.com')

colours = ["red", "green", "blue", "yellow", "orange", "grey", "purple", "pink", "cyan", "brown"]

(0..9).each do |verts|
  name = 5.times.map{|time| ("A".."z").to_a[rand()*52] }.join("")
  colour = colours[rand() * colours.length]

  pet = if verts <= 4
    Pet.create!({user: user, vertices: verts, name: name, colour: colour})
  else
    Pet.create!({user: user_1, vertices: verts, name: name, colour: colour})
  end
end

