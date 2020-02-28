Rails.application.routes.draw do
  root 'posts#index'
  get 'about' => 'home#about'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :posts do
    collection do
      get :mydreams, :userdreams
    end
  end
end
