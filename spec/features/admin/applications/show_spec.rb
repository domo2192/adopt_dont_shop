require 'rails_helper'

RSpec.describe 'When I visit an admin application show page' do
  before :each do
    @dominic = Application.create!(name: "Dominic", street: "2298 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 cats", application_status: "Pending" )
    @jordan = Application.create!(name: "Jordan", street: "2300 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 dogs", application_status: "Approved" )
    @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @shelter2 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    @pet3 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    ApplicationPet.create!(application: @dominic, pet: @pet1)
    ApplicationPet.create!(application: @dominic, pet: @pet2)
    ApplicationPet.create!(application: @dominic, pet: @pet3)
    ApplicationPet.create!(application: @jordan, pet: @pet1)
    visit "/admin/applications/#{@dominic.id}"
  end

  #story test 11
  it "has a button to approve or reject pets" do
     expect(page).to have_button("Approve")
     expect(page).to have_button("Reject")
   end

   it "updates page and displays new result after button click" do

     approve = first(:button, "Approve")
     approve.click
     expect(page).to have_content("#{@pet1.name} Approved")
     expect(first(:button, "Approve")).to_not eq(approve)
     first(:button, "Approve").click
     expect(page).to have_content("Application Status: Pending")

     visit "/admin/applications/#{@jordan.id}"
     reject = first(:button, "Reject", disabled:false)
     reject.click
     expect(page).to have_content("Rejected")

     expect(page).to have_content("Application Status: Rejected")
   end


  it "sets pet adoptable? to false when approved" do
    approve = first(:button, "Approve")
    approve.click
    approve = first(:button, "Approve")
    approve.click

    visit "/admin/applications/#{@jordan.id}"

    expect(page).to have_button("Adopted", disabled: true)
  end
end
