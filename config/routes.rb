Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stories do
    member do
      post :clap
    end
    resources :comments,only:[:create]
  end

  #/@user/文章標題-123
   get '@:username/:story_id',to:'pages#show',as:'story_page'
   #/@user/
   get '@:username',to:'pages#user',as:'user_page'
  root "pages#index"
end
