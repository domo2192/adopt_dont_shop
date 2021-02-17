class Shelter < ApplicationRecord
  has_many :pets

  def self.reverse_names
    order(name: :asc)
  end
end
