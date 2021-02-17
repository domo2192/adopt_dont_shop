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
end
