Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/login", to: redirect("/auth/google_oauth2")
  get 'auth/google_oauth2/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  resources :tasks
end
