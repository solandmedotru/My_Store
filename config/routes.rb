Rails.application.routes.draw do
  resources :items do
    get :upvote, on: :member
    get :expensive, on: :collection
  end
  root 'items#index'

end
