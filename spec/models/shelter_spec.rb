require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  it "should order shelters reverse alpha" do
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    expected = Shelter.reverse_names
    expect(expected).to eq([shelter3, shelter1, shelter2])

  end

  it "should be able to find the count of adoptable pets" do
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    pet2 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    pet3 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female", adoptable: "false")
    expect(shelter1.count_adoptable).to eq(1)
    expect(shelter2.count_adoptable).to eq(1)
  end

  it "should be able to find the average age of pets in the shelter" do
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    shelter2 = Shelter.create!(name: "Tilly Shelter", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    shelter3 = Shelter.create!(name: "Furry Friends", address: "123 Silly Ave", city: "Denver", state: "CO", zip: 80012)
    pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 3, sex: "male")
    pet2 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 8, sex: "female")
    pet3 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 4, sex: "female")
    expect(shelter1.average_age).to eq(2.5)
    expect(shelter2.average_age).to eq(6)
  end
end
