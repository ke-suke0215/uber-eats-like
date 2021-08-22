class Restaurant < ApplicationRecord
  has_many :foods
  has_many :line_foods, through: :foods

  # validates はカラムのデータに対して制限を課す
  validates :name, :fee, :time_required, presence: true
  validates :name, length: {　maximum: 30 }
  # fee が0以上であることを条件とする
  validates :fee, numericality: { greater_than: 0 }
end