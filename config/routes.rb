Rails.application.routes.draw do
  root "static_pages#home"

  namespace :admin do
    resources :categories
    resources :news
  end
end
