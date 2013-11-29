Socialbot::Application.routes.draw do
  get '/' => 'message#index'
  get '/:action' => 'message'
  post '/:action' => 'message'
end
