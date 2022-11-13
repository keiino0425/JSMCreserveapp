Rails.application.routes.draw do
  devise_for :teachers, controllers: {
    sessions:      'teachers/sessions',
    registrations: 'teachers/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users do
    resources :teachers do
      resources :reservations
    end
    get '/choice', to: 'reservations#choice'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
