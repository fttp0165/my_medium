Rails.application.routes.draw do

   
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions', 
    registrations: 'users/registrations'  }
  
  
 
  namespace :api do
    post :upload_image, to: 'utils#upload_image'
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

#會員付費路徑
  resources :users,only:[] do
    collection do
      get :pricing   #/users/pricing(.:format)
      get :payment   #/users/payment(.:format)
      post :pay
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
   get 'hot_stories',to:'pages#hot',as:'hot_page'
   get 'pop_stories',to:'pages#pop',as:'pop_page'
   root "pages#index"
end
