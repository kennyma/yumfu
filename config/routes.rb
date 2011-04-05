Yumfu::Application.routes.draw do
  devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/signup" => "devise/registrations#new"
  end
  

  resources :recipes
  
  root :to => "recipes#index"
end
