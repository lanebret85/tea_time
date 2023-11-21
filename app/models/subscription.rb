class Subscription < ApplicationRecord
  enum status: { ordered: 0, shipped: 1, delivered: 2 }
  enum frequency: { weekly: 0, monthly: 1, quarterly: 2 }

  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true
end