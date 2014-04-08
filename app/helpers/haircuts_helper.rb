module HaircutsHelper
  def photo_url(haircut)
    if cookies[:is_retina]
      haircut.photo(:retina)
    else
      haircut.photo(:normal)
    end
  end

  def haircut_route(url)
    "/haircuts/#{url}"
  end

  def highest_bid(haircut)
    if haircut.bids.empty?
      "No bids yet"
    else
      number_to_currency(highest_bid_for(haircut).amount)
    end
  end

  def highest_bidder_name(haircut)
    highest_bid_for(haircut) ? highest_bid_for(haircut).user.name : ""
  end

  def highest_bidder_email(haircut)
    highest_bid_for(haircut) ? highest_bid_for(haircut).user.email : ""
  end

  def highest_bidder_placed(haircut)
    highest_bid_for(haircut) ? format_date_time(highest_bid_for(haircut).created_at) : ""
  end

  def highest_bid_for(haircut)
    haircut.bids.order('amount DESC').first
  end
end
