class Bid < ActiveRecord::Base
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 10 }

  belongs_to :user, inverse_of: :bids
  belongs_to :haircut, inverse_of: :bids

  before_validation :check_if_bidding_is_open, :multiple_of_five

  validates_presence_of :user, :haircut

  def self.open
    DateTime.now.in_time_zone('Pacific Time (US & Canada)') < DateTime.new(2014, 5, 2).change(offset: '-7')
  end

  def self.time_left
    if self.open
      Time.new(2014, 5, 2).change(offset: '-6') - DateTime.now.in_time_zone('Mountain Time (US & Canada)')
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

  def self.total
    Haircut.all.map { |haircut| haircut.bids.maximum("amount") }.compact.inject(:+)
  end
end
