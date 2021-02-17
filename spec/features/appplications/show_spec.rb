require 'rails_helper'

RSpec.describe 'Applications show page' do
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
  end
    #story test 2
  it "can show appplicant information" do
    visit "/applications/#{@dominic.id}"
    within "#application-#{@dominic.id}" do
      expect(page). to have_content(@dominic.name)
      expect(page). to have_content(@dominic.street)
      expect(page). to have_content(@dominic.city)
      expect(page). to have_content(@dominic.state)
      expect(page). to have_content(@dominic.zip_code)
      expect(page). to have_content(@dominic.description)
      expect(page). to have_content(@dominic.application_status)
      expect(page). to have_link(@pet1.name)
    end
  end

  #Story test 5
  it "can add a pet on your application show page" do
    david = Application.create!({name: 'David', street: "101 new street", city: 'Aurora', state: 'CO', zip_code: 80017,
                                          description: 'I love kittens', application_status: 'In Progress'})
    pet4 = @shelter2.pets.create!(image:"", name: "Linel", description: "cat", approximate_age: 3, sex: "female")
    visit "/applications/#{david.id}"
    expect(page).to have_content("Add a pet to your application:")
    fill_in "search", with: "#{pet4.name}"
    click_on "Search Pets"

    expect(current_path).to eq("/applications/#{david.id}")
    expect(page).to have_content("#{pet4.name}")
  end
  #Story test 6
  it "can add the pet to your list of pets that you have applied for with adopt button" do
    david = Application.create!({name: 'David', street: "101 new street", city: 'Aurora', state: 'CO', zip_code: 80017,
                                          description: 'I love kittens', application_status: 'In Progress'})
    pet4 = @shelter2.pets.create!(image:"", name: "Linel", description: "cat", approximate_age: 3, sex: "female")
    visit "/applications/#{david.id}"
    fill_in "search", with: "#{pet4.name}"
    click_button("Search Pets")
    expect(page).to have_button("Adopt this Pet")
    click_button("Adopt this Pet")
    expect(page).to have_link(pet4.name)
  end

# story test 7
  describe "When I am on an applications show page" do
  describe "I add a pet and complete description section" do
    it "Taken back to apps show page after submiting" do
      visit "/applications/#{@jordan.id}"

      expect(@jordan.pets.count).to eq 1
      within("#tell-us-why") do
        expect(page).to have_button("Submit Application")
      end
      fill_in "description", with: "Multiple dog owner"
      click_button("Submit Application")
      expect(current_path).to eq("/applications/#{@jordan.id}")
      expect(page).to have_content("Multiple dog owner")
      expect(page).to have_content("Pending")
      expect(page).to have_content(@pet1.name)
      end
    end
  end

  #story test 8
  it "I don't see any button to submit application or description if no pets are adopted" do
    david = Application.create!({name: 'David', street: "101 new street", city: 'Aurora', state: 'CO', zip_code: 80017,
                                          description: 'I love kittens', application_status: 'In Progress'})
      visit "/applications/#{david.id}"
      expect(david.pets.count).to eq 0
      within("#tell-us-why") do
      expect(page).not_to have_button("Submit Application")
    end
  end
  #story test 9
  it "I can search for pets by partial names" do
    david = Application.create!({name: 'David', street: "101 new street", city: 'Aurora', state: 'CO', zip_code: 80017,
                                        description: 'I love kittens', application_status: 'In Progress'})
    pet4 = @shelter2.pets.create!(image:"", name: "Linel", description: "cat", approximate_age: 3, sex: "female")
    visit "/applications/#{david.id}"
    fill_in "search", with: "Lin"
    click_button("Search Pets")
    expect(page).to have_button("Adopt this Pet")
    click_button("Adopt this Pet")
    expect(page).to have_link(pet4.name)
  end

  #story test 10
  it "I can search for pets by partial names" do
    david = Application.create!({name: 'David', street: "101 new street", city: 'Aurora', state: 'CO', zip_code: 80017,
                                        description: 'I love kittens', application_status: 'In Progress'})
    pet4 = @shelter2.pets.create!(image:"", name: "Linel", description: "cat", approximate_age: 3, sex: "female")
    visit "/applications/#{david.id}"
    fill_in "search", with: "liNeL"
    click_button("Search Pets")
    expect(page).to have_button("Adopt this Pet")
    click_button("Adopt this Pet")
    expect(page).to have_link(pet4.name)
  end
end
