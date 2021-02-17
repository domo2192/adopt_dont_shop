class AdminApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def status
     application_pet = ApplicationPet.where(pet_id: params[:pet],application_id: params[:id]).first
     application_pet.status = params[:decision]
     application_pet.pet.adoptable = false if params[:decision] == "Approved"
     application_pet.save
     application_pet.pet.save
     @application = Application.find(params[:id])
     @application.evaluate
     redirect_to "/admin/applications/#{params[:id]}"
   end
end
