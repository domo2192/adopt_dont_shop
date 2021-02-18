class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
  has_many :applications, through: :application_pets
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.search(input)
   where("name ILIKE ?", "%#{input[:search]}%")
 end

  def application_result(app_id)
    ApplicationPet.where(pet_id: id, application_id: app_id).first.status
  end

  def pets_with_pending_apps
    application_pets.where("status IS NULL")
  end
end
