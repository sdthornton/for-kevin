module BidsHelper
  def bid_total
    number_to_currency(Bid.total)
  end
end
