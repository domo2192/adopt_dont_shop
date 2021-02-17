class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_names 
  end
end
