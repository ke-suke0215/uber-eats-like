# module で名前空間を指定
module Api
  module V1
    class RestaurantsController < ApplicationController
      def index
        restaurants = Restaurant.all

        # JSON形式でデータを返す書き方
        # statsu: :ok はリクエスト成功時に「200 OK」と一緒にデータを返してくれる
        render json: {
          restaurants: restaurants
        }, status: :ok
      end
    end
  end
end

