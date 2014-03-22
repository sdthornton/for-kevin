class Bid < ActiveRecord::Base
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 15 }

  belongs_to :user, inverse_of: :bids
  belongs_to :haircut, inverse_of: :bids

  before_validation :check_if_bidding_is_open

  validates_presence_of :user, :haircut

  def self.open
    DateTime.now.in_time_zone('Mountain Time (US & Canada)') < DateTime.new(2014, 5).change(offset: '-6')
  end

  def self.time_left
    Time.new(2014, 5).change(offset: '-6') - Time.now
  end

  def check_if_bidding_is_open
    unless Bid.open
      errors.add(:base, "Sorry, it looks like bidding has closed for the year. But don't worry! We'll be doing this again next year!")
    end
  end

  def self.total
    Haircut.all.map { |haircut| haircut.bids.maximum("amount") }.compact.inject(:+)
  end
end
