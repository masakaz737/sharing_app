class Item < ApplicationRecord
  belongs_to :user
  has_many :deals

  validates :name, presence: true
  validates :price, presence: true
  validates :condition, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 3
    }
  validates :available, null: false, inclusion: { in: [true, false] }
end
