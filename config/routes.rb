Socialbot::Application.routes.draw do
  devise_for :admins
	root 'pages#index'

	get '/admin' => 'pages#admin'

  get '/' => 'message#index'
  get '/:action' => 'message'
  post '/:action' => 'message'
end