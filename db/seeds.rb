# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")
# Ingredient.create(name: "coconut milk")
# Ingredient.create(name: "pineapple juice")
# Ingredient.create(name: "vodka")
# Ingredient.create(name: "rum")
# Ingredient.create(name: "tequila")

require 'open-uri'
require 'json'

Cocktail.destroy_all

json = open("http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=vodka").read
my_hash = JSON.parse(json)["drinks"]
my_hash.each do |drink|
  drink_name = drink["strDrink"]
  drink_image = "http://"+drink["strDrinkThumb"]
  drink_id = drink["idDrink"]
  c = Cocktail.create(name: drink_name, remote_image_url: drink_image)
  p c

  json = open("http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink_id}").read
  my_drink = JSON.parse(json)["drinks"][0]

  c.instruction = my_drink["strInstructions"]


  c.save

  for i in (1..15).to_a do
    ingred = my_drink["strIngredient#{i}"]
    des = my_drink["strMeasure#{i}"]
    if ingred != "" && ingred != nil
      ingred
      # p des
      unless i = Ingredient.find_by_name(ingred)
        i = Ingredient.create(name: ingred)
        i.save
      end
      data = {cocktail_id: c.id, ingredient_id: i.id, description: des}
      d = Dose.create(data)
      d.save
    end
  end
end

puts "Finished"


