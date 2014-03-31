module BidsHelper
  def bid_total
    number_to_currency(Bid.total)
  end

  def bid_count
    Bid.all.count
  end
end
