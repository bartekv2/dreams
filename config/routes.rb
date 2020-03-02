Rails.application.routes.draw do
  root 'posts#index'
  get 'about' => 'home#about'

  devise_for :users
  resources :users, :controller => "users"

  resources :posts do
    resources :comments
    collection do
      get :mydreams, :userdreams
    end
  end
end
