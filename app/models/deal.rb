class Deal < ApplicationRecord
  belongs_to :item
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"

  validates :item_id, presence: true
  validates :lender_id, presence: true
  validates :borrower_id, presence: true
  validates :unit_price, presence: true

  def borrower?(current_user)
    borrower_id == current_user.id
  end
end
