Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  delete "/plot_plants", to: 'plot_plants#destroy'

  resources :plots, only: %i[index]
  
  resources :plot_plants
end
