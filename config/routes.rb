ContactsExample40::Application.routes.draw do
  get 'news_releases',      to: 'news_releases#index', as: 'news_releases'
  get 'news_release',       to: 'news_releases#show',  as: 'news_release'
  get 'news_releases/new',  to: 'news_releases#new',   as: 'new_news_release'
  post 'news_releases',     to: 'news_releases#create'


  get 'signin', to: 'users#new',        as: 'signup'
  get 'login',  to: 'sessions#new',     as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  patch 'contacts/hide_contact', to: 'contacts#hide_contact'

  resources :users
  resources :sessions

  resources :contacts

  root to: 'contacts#index'
end
