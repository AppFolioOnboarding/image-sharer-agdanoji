Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htm
  root 'images#new'
  resources :images, only: %i[new create show index]
end
