Rails.application.routes.draw do
  root to: 'power_generators#index'
  resources :power_generators, only: %i[index show] do
    get 'recommenda', on: :collection
    get 'freight_cost', on: :member
    get 'search', on: :collection
  end
end
