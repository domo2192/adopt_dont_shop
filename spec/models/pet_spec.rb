require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :approximate_age}
    it {should validate_numericality_of(:approximate_age).is_greater_than_or_equal_to(0)}

    it 'is created as adoptable by default' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(true)
    end

    it 'can be created as not adoptable' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(adoptable: false, name: "Fluffy", approximate_age: 3, sex: 'male', description: 'super cute')
      expect(pet.adoptable).to eq(false)
    end

    it 'can be male' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :male, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('male')
      expect(pet.male?).to be(true)
      expect(pet.female?).to be(false)
    end

    it 'can be female' do
      shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
      pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
      expect(pet.sex).to eq('female')
      expect(pet.female?).to be(true)
      expect(pet.male?).to be(false)
    end
  end

  it 'Can search by name for pets' do
     shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
     pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
     pet2 = shelter.pets.create!(sex: :female, name: "Doge", approximate_age: 3, description: 'super cute')
     search = {search: "Fluffy"}
     expected = Pet.search(search)
     expect(expected.first.name).to eq("Fluffy")
  end

  it "should search for names in any case" do
    shelter = Shelter.create!(name: 'Pet Rescue', address: '123 Adoption Ln.', city: 'Denver', state: 'CO', zip: '80222')
    pet = shelter.pets.create!(sex: :female, name: "Fluffy", approximate_age: 3, description: 'super cute')
    pet2 = shelter.pets.create!(sex: :female, name: "Doge", approximate_age: 3, description: 'super cute')
    search = {search: "FlUfFy"}
    expected = Pet.search(search)
    expect(expected.first.name).to eq("Fluffy")
  end

  it "can return results application_results for pets" do
    jordan = Application.create!(name: "Jordan", street: "2300 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 dogs", application_status: "Approved" )
    shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    shelter2 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
    pet1 = shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
    pet2 = shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
    ApplicationPet.create!(application: jordan, pet: pet1)
    ApplicationPet.create!(application: jordan, pet: pet2)
    expect(pet1.application_result(jordan.id)).to eq(nil)
  end
end
