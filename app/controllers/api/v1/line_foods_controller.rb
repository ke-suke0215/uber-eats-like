module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create reprace]

      def index
        # model/line_food.rb でactiveを定義している
        # active が true な line_food を配列として取得
        line_foods = LineFood.active
        if line_foods.exists?
          render json: {
            line_food_ids: line_foods.map { |line_food| line_food.id },
            restaurant: line_foods[0].restaurant,
            # 商品の合計個数
            count: line_foods.sum { |line_food| line_food[:count] },
            # 合計金額
            amount: linefoods.sum { |line_food| line_food.total_amount },
          }, status: :ok
        else
          # line_food をセットせずにurlだけ送信された場合の例外処理
          render json: {}, status: :no_content
        end
      end

      def create
        # 例外パターンで早期リターン
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
            }, status: :not_acceptable 
        end

        set_line_food(@ordered_food)

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      # 別の店で商品を選んでいた場合、それを削除して新しい line_food を作成する
      def replace
        # 別の line_food の active を false にする
        LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
          line_food.update_attribute(:active, false)
        end
      end

      set_line_food(@ordered_food)

      if @line_food.save!
        render json: {
          line_food: @line_food
        }, status: :created
      else
        render json: {}, status: :internal_server_error
      end

      # このコントローラー内のみで使用するメソッドを記述
      private
        def set_food
          @ordered_food = Food.find(params[:food_id])
        end

        # line_foodインスタンスの生成
        def set_line_food(ordered_food)
          # 元からfoodに対するline_foodがあるか判定
          if ordered_food.line_food.present?
            @line_food = ordered_food.line_food
            @line_food.attributes = {
              count: ordered_food.line_food.count + params[:count],
              active: true
            }
          else
            @line_food = ordered_food.build_line_food(
              count: params[:count],
              restaurant: ordered_food.restaurant,
              active: true
            )
          end
        end
    end
  end
end