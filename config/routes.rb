Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  delete "/shelters/:id", to: "shelters#destroy"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"


  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"


  #application routes
  get "/applications", to:"applications#index"
  get "/applications/new", to: 'applications#new'
  get "/applications/:id", to:'applications#show'
  post "/applications", to: 'applications#create'
  patch "/applications/:id/update", to: "applications#update"
  patch "/applications/:id", to: 'applications#show'
  patch "/applications/:id/edit", to: "applications#edit"


  # admin applications routes
  get "admin/applications", to: "admin_applications#index"
  get "/admin/applications/:id", to: "admin_applications#show"
  post "/admin/applications/:id", to: "admin_applications#edit"

  #admin shelter routes
  get "admin/shelters", to: "admin_shelters#index"
  get "admin/shelters/:id", to: "admin_shelters#show"
end
