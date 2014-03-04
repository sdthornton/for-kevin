class Bid < ActiveRecord::Base
  validates :amount, presence: true

  belongs_to :user, inverse_of: :bids
  belongs_to :haircut, inverse_of: :bids

  validates_presence_of :user, :haircut
end
