class Bid < ActiveRecord::Base
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 10 }

  belongs_to :user, inverse_of: :bids
  belongs_to :haircut, inverse_of: :bids

  before_validation :check_if_bidding_is_open, :multiple_of_five, :set_bidding_year

  validates_presence_of :user, :haircut

  def self.open
    Time.zone.now < SystemConfig.close_bidding_at
  end

  def self.time_left
    if self.open
      SystemConfig.close_bidding_at - Time.zone.now
    else
      0
    end
  end

  def check_if_bidding_is_open
    unless Bid.open
      errors.add(:base, ": Sorry, it looks like bidding has closed for the year. But don't worry! We'll be doing this again next year!")
    end
  end

  def multiple_of_five
    if self.amount.present? && self.amount % 5 != 0
      errors.add(:amount, "must be a multiple of five")
    end
  end

  def set_bidding_year
    self.bidding_year = bidding_year || SystemConfig.instance.current_bidding_year
  end

  def self.total
    Haircut.joins(:bids)
      .where("bids.bidding_year = ?", SystemConfig.current_bidding_year)
      .map { |haircut| haircut.bids.maximum("amount") }.compact.inject(:+)
  end
end
