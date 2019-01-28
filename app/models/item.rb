class Item < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  validates :name, presence: true
  validates :price, presence: true
  validates :condition, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 3
    }
  validates :available, null: false, inclusion: { in: [true, false] }

  def owner?(current_user)
    user_id == current_user.id
  end

  def create_item_deals(current_user)
    deals.new(
      lender_id: user_id,
      borrower_id: current_user.id,
      unit_price: price,
    )
  end
end
