Rails.application.routes.draw do
  # namespace で名前空間を表す
  # 今回の場合コントローラーは app/controllers/api/vi/### に作成
  namespace :api do
    namespace :v1 do
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
