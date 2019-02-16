class Item < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images

  validates :name, presence: true
  validates :price, presence: true
  validates :condition, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 3
    }
  validates :available, null: false, inclusion: { in: [true, false] }

  scope :get_by_name, ->(name) {
    where("items.name like ?", "#{name}%") if name.present?
  }

  scope :get_by_category, ->(category_id) {
    joins(:categories).where(categories: {id: category_id}) if category_id.present?
  }

  def owner?(current_user)
    user_id == current_user.id
  end

  def exist_progress_deals?
    deals.progress.present?
  end

  def self.search_by(name, category_id)
    get_by_name(name).get_by_category(category_id)
  end
end
