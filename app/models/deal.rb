class Deal < ApplicationRecord
  belongs_to :item
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"

  enum status: { submitted: 0, approved: 1, delivered: 2, return: 3, rejected: 4, cancelled: 5 }

  validates :item_id, presence: true
  validates :lender_id, presence: true
  validates :borrower_id, presence: true
  validates :unit_price, presence: true
  validates :status, null: false,
    inclusion: { in: [
      'submitted', 'approved', 'delivered', 'return', 'rejected', 'cancelled'
      ] }

  def borrower?(current_user)
    borrower_id == current_user.id
  end
end
