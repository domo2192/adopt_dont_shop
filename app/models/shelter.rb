class Shelter < ApplicationRecord
  has_many :pets

  def self.reverse_names
    order(name: :asc)
  end

  def self.shelters_with_pending
  end

  def count_adoptable
    pets.where("adoptable = 'true'").count
  end

  def average_age
    pets.where("adoptable = 'true'").average(:approximate_age)
  end
end
