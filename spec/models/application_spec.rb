require 'rails_helper'

describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :application_pets}
    it{ should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :description}
    it { should validate_presence_of :zip_code}
    it { should validate_numericality_of(:zip_code) }
  end

  describe 'instance methods' do
    before :each do
      @jordan = Application.create!(name: "Jordan", street: "2300 West 28th Ave", city: "Denver", state: "Colorado", zip_code: 80211, description:"Own 10 dogs", application_status: "Approved" )
      @shelter1 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @shelter2 = Shelter.create!(name: "Shady Shelter", address: "123 Shady Ave", city: "Denver", state: "CO", zip: 80011)
      @pet1 = @shelter1.pets.create!(image:"", name: "Thor", description: "dog", approximate_age: 2, sex: "male")
      @pet2 = @shelter2.pets.create!(image:"", name: "Athena", description: "cat", approximate_age: 3, sex: "female")
      ApplicationPet.create!(application: @jordan, pet: @pet1)
      ApplicationPet.create!(application: @jordan, pet: @pet2)
    end
    it "returns true if all pets are approved" do
      ApplicationPet.first.update(status: :Approved)
      ApplicationPet.last.update(status: :Approved)

      expect(@jordan.all_pets_approved).to eq(true)
    end

    it "all pets reject returns false if any pets are rejected" do
      ApplicationPet.first.update(status: :Approved)
      ApplicationPet.last.update(status: :Rejected)

      expect(@jordan.all_pets_approved).to eq(false)
    end

    it "returns nothing until all pets are aproved" do
      ApplicationPet.first.update(status: :Approved)
      expect(@jordan.all_pets_approved).to eq(false)
      expect(@jordan.evaluate).to eq(nil)
    end

    it "all pets rejected returns true if any pets are rejected" do
      ApplicationPet.first.update(status: :Approved)
      ApplicationPet.last.update(status: :Rejected)
      expect(@jordan.any_pets_rejected).to eq(true)
    end
  end
end
