class Bid < ActiveRecord::Base
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 15 }

  belongs_to :user, inverse_of: :bids
  belongs_to :haircut, inverse_of: :bids

  validates_presence_of :user, :haircut

  def self.total
    Haircut.all.map { |haircut| haircut.bids.maximum("amount") }.compact.inject(:+)
  end
end
