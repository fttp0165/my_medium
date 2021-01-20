Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  namespace :api do
    resources :users ,only:[] do
      member do
        post :follow
      end
    end

    resources :stories,only:[] do
      member do
        post :clap
      end
    end

    resources :stories,only:[] do
      member do
        post :bookmark
      end
    end
    
  end


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
