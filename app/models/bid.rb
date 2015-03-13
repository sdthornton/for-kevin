class Bid < ActiveRecord::Base
  validates :amount, presence: true,
    numericality: { greater_than_or_equal_to: 10 }

  belongs_to :user, inverse_of: :bids
  belongs_to :haircut, inverse_of: :bids, touch: true

  before_validation :check_if_bidding_is_open, :is_multiple_of_five, :is_greater_bid
  before_save :set_bidding_year

  validates_presence_of :user, :haircut

  def self.open
    @bid_open ||= (Time.zone.now < SystemConfig.close_bidding_at)
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
      errors.add(:base, ": Sorry, it looks like bidding has closed for the year.
        But don't worry! We'll be doing this again next year!")
    end
  end

  def is_multiple_of_five
    if self.amount.present? && self.amount % 5 != 0
      errors.add(:amount, "must be a multiple of five")
    end
  end

  def is_greater_bid
    if self.amount.present? && haircut.bids.count > 0 && self.amount <= haircut.bids.maximum("amount")
      errors.add(:amount, "must be greater than previous bid")
    end
  end

  def set_bidding_year
    self.bidding_year = bidding_year || SystemConfig.current_bidding_year
  end

  def self.total
    @bid_total ||=
      Bid.joins(:haircut)
        .where('bids.bidding_year = ?', SystemConfig.current_bidding_year)
        .where('bids.amount = (SELECT MAX(bids.amount) FROM bids WHERE bids.haircut_id = haircuts.id)')
        .sum('amount')
  end
end
