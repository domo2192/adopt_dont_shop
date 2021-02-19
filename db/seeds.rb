# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Application.destroy_all
Shelter.destroy_all
ApplicationPet.destroy_all

dominic = Application.create!(name: "Dominic", street: "2298 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 cats", application_status: "Pending" )
jordan = Application.create!(name: "Jordan", street: "2300 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 dogs", application_status: "Pending" )
shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
shelter2 = Shelter.create!(name: "Furry Friends", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
shelter3 = Shelter.create!(name: "Adoptable", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
pet2 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
pet3 = shelter2.pets.create!(image:"", name: "Ruby", description: "pig", approximate_age: 5, sex: "female")
pet4 = shelter2.pets.create!(image:"", name: "Johnny", description: "cat", approximate_age: 3, sex: "female")
pet5 = shelter2.pets.create!(image:"", name: "Elvis", description: "cat", approximate_age: 3, sex: "female")
pet5 = shelter3.pets.create!(image:"", name: "Kitty", description: "cat", approximate_age: 6, sex: "female")
ApplicationPet.create!(application: dominic, pet: pet1)
ApplicationPet.create!(application: dominic, pet: pet2)
ApplicationPet.create!(application: dominic, pet: pet3)
ApplicationPet.create!(application: jordan, pet: pet1)
