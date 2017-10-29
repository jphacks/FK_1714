Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, default: {format: :json} do
    resources :memos, only: :create
  end
  
  get  'bbb' => 'application#aaa'
  get 'show' => "api/memos#show"

end
