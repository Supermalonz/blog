Rails.application.routes.draw do
  resources :articles do
    resources :comments, only: %i[new create destroy]
  end

  root "articles#index"
end
