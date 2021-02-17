class Application < ApplicationRecord
  validates :name, :city, :state, :description, presence: true
  validates :zip_code, numericality: { only_integer: true }, presence: true
  has_many :application_pets
  has_many :pets, through: :application_pets


  def evaluate
    if all_pets_approved
      update(application_status: "Approved")
    elsif any_pets_rejected
      update(application_status: "Rejected")
    end
  end

  def all_pets_approved
    application_pets.all? {|app_pet| app_pet.status=="Approved"}
  end

  def any_pets_rejected
    application_pets.any? {|app_pet| app_pet.status=="Rejected"}
  end
end
