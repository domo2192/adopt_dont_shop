class Shelter < ApplicationRecord
  has_many :pets

  def self.reverse_names
    order(name: :asc)
  end

  def self.shelters_with_pending
    joins(pets: :application_pets).where(status: nil)
  end

  def count_adoptable
    pets.where("adoptable = 'true'").count
  end

  def average_age
    pets.where("adoptable = 'true'").average(:approximate_age)
  end

  def pending_pets
    pets.joins(:application_pets).where("status IS NULL")
  end

  def adopted_pets
    pets.where("adoptable = 'false'").count
  end
end
