class Deal < ApplicationRecord
  belongs_to :item
  belongs_to :lender, class_name: "User"
  belongs_to :borrower, class_name: "User"

  enum status: { submitted: 0, approved: 1, delivered: 2, return: 3, rejected: 4, cancelled: 5 }

  validates :item_id, presence: true
  validates :lender_id, presence: true
  validates :borrower_id, presence: true
  validates :unit_price, presence: true
  validates :status, inclusion: { in: Deal.statuses.keys }

  scope :progress, -> { where(status: 0..2) }
  scope :not_outdated, -> { where(status: 0..3) }
  scope :outdated, -> { where(status: 4..5) }
  scope :not_deleted, -> { where(deleted_at: nil) }

  def borrower?(current_user)
    borrower_id == current_user.id
  end
end
