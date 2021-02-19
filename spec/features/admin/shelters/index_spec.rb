require 'rails_helper'

RSpec.describe 'When I visit an admin Shelter index page' do
  it "should show sorted names by shelter names" do
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
   visit "/admin/shelters"
   expect(page).to have_link(shelter3.name)
   expect(page).to have_link(shelter1.name)
   expect(page).to have_link(shelter2.name)
   expect(shelter3.name).to appear_before(shelter1.name)
   expect(shelter1.name).to appear_before(shelter2.name)

 end

 it "should have a section that shows the name of each shelter with pending applications" do
   dominic = Application.create!(name: "Dominic", street: "2298 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 cats", application_status: "Pending" )
   shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
   shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
   shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
   pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
   pet2 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
   pet3 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
   ApplicationPet.create!(application: dominic, pet: pet1)
   ApplicationPet.create!(application: dominic, pet: pet2)
   visit"/admin/shelters"
   save_and_open_page
   within("#pending-apps-") do
     expect(page).to have_content(shelter1.name)
     expect(page).to have_content(shelter2.name)
   end
 end

end
