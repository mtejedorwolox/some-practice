Rails.application.routes.draw do
  root to: 'application#index'

  mount Sidekiq::Web, at: 'sidekiq'

  get 'api/questions', to: 'application#questions'
end
