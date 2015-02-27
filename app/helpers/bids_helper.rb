module BidsHelper
  def bid_total
    number_to_currency(Bid.total) || number_to_currency(0)
  end

  def bid_count
    Bid.where(bidding_year: @system_config.current_bidding_year).count
  end
end
