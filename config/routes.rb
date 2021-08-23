Rails.application.routes.draw do
  namespace :api do
    namespace :vi do
      resources :restaurants do
        resources :foods, only: %i[index]
      end
      resources :line_foods, only: %i[index create]

      # resources で生成できない独自のルーティングを設定
      put 'line_foods_replace', to: 'line_foods#replace'
      resources :orders, only: %i[create]
    end
  end
end
