Rails.application.routes.draw do

  resources :repositories do
    get "more", on: :collection
  end
  root 'pages#home'
  get '/search' => 'pages#search', :as => 'search_page'
end
