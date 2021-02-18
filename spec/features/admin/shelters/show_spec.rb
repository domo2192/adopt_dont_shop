require 'rails_helper'

RSpec.describe 'When I visit an admin Shelter show page' do
  it "should show sorted names by shelter names" do
    Shelter.destroy_all
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
   visit "/admin/shelters"
   click_link(shelter1.name)
   expect(current_path).to eq("/admin/shelters/#{shelter1.id}")
   expect(page).to have_content(shelter1.name)
   expect(page).to have_content("#{shelter1.address}, #{shelter1.city}, #{shelter1.state}, #{shelter1.zip}")
 end

 it "should find pets that are adoptable and count them" do
   dominic = Application.create!(name: "Dominic", street: "2298 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 cats", application_status: "Pending" )
   jordan = Application.create!(name: "Jordan", street: "2300 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 dogs", application_status: "Pending" )
   shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
   shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
   shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
   pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
   pet2 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
   pet3 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
   ApplicationPet.create!(application: dominic, pet: pet1)
   ApplicationPet.create!(application: dominic, pet: pet2)
   visit"/admin/shelters/#{shelter2.id}"
   expect(page).to have_content("We have 2 adoptable pets")

 end

 it "should show our users the average age of adoptable pets" do
   shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
   pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 5, sex: "male")
   pet2 = shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
   pet3 = shelter1.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 1, sex: "female")
   visit"/admin/shelters/#{shelter1.id}"
   expect(page).to have_content("Our adoptable pets average age is: 3.0")
 end
end
