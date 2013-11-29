Socialbot::Application.routes.draw do
  post 'sms' => 'receive_text#index'
end