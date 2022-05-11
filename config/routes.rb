Rails.application.routes.draw do
  resources :articles, :comments
  # only: %i[update index create destroy]

  root "articles#index"
end
