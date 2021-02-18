class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_names
    @shelters_with_apps = Shelter.shelters_with_pending
  end

  def show
    @shelter = Shelter.find(params[:id])
    @pets = @shelter.pets
  end
end
