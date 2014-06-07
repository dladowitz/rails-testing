ContactsExample40::Application.routes.draw do
  get 'signin', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  patch 'contacts/hide_contact', to: 'contacts#hide_contact'

  resources :users
  resources :sessions

  resources :contacts

  root to: 'contacts#index'
end
