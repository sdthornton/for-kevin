module BidsHelper
  def bid_total
    number_to_currency(Bid.total) || number_to_currency(0)
  end

  def bid_count
    Bid.all.count
  end
end
