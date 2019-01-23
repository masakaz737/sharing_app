class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy

  has_many :lending_deals, foreign_key: 'lender_id', class_name: 'Deal', dependent: :destroy
  has_many :borrowers, through: :lending_deals, source: :borrower

  has_many :borrowing_deals, foreign_key: 'borrower_id', class_name: 'Deal', dependent: :destroy
  has_many :lenders, through: :borrowing_deals, source: :lender
end
