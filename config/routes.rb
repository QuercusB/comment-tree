Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  defaults format: :json do 
    resources :users, controller: :users, only: [:index, :show, :create, :destroy]

    resources :threads, controller: :threads, only: [:index, :show, :create, :destroy] do
      resources :comments, controller: :thread_comments, only: [:index, :show, :create, :destroy] do
        member do
          post :comments, action: :create_child
        end
      end
    end
  end

end
