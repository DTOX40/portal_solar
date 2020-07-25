Rails.application.routes.draw do

  get 'recommenda', controller: :power_generators

  root to: 'power_generators#index'
  
  resources :home, only: %i[index]
  resources :power_generators, only: %i[index]
end
