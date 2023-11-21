class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :subscription_teas, through: :subscriptions
  has_many :teas, through: :subscription_teas

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address, presence: true
end