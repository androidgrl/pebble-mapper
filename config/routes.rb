Rails.application.routes.draw do
  resources :direction, param: :latlon, only: :show
end
