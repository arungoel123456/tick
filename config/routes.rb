Rails.application.routes.draw do


  delete  '/comments/destroy'   => 'comments#destroy'
 
  get     '/comments/get_all'   => 'comments#get_all'

  get     '/mail/send'          => 'mail#send'
  post    '/comments/create'    => 'comments#create'

  get     '/card/show'          => 'card#show'
  post    '/card/unassign'      => 'card#unassign'
  get     '/card/assigned'      => 'card#assigned'
  post    '/card/assign'        => 'card#assign'
  get     '/users/get_all'      => 'users#get_all'
  get     '/users/admin_login'  => 'users#admin_login'

  # getting mails
  get     '/mail/retrieve'      => 'mail#retrieve'

	  # Home controller routes.
  root   'home#index'
  get    '/auth'                => 'home#auth'
  
  # Get login token from Knock
  post   '/user_token'          => 'user_token#create'
  
  # User actions
  get     '/users/show'         => 'users#show'
  get    '/users'               => 'users#index'
  get    '/users/current'       => 'users#current'
  post   '/users/create'        => 'users#create'
  patch  '/user/:id'            => 'users#update'
  delete '/user/:id'            => 'users#destroy'

 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
