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

  def highest_bid(haircut, currency = true)
    if currency == true
      if haircut.bids.empty?
        "No bids yet"
      else
        number_to_currency(highest_bid_for(haircut).amount)
      end
    else
      haircut.bids.empty? ? "0" : highest_bid_for(haircut).amount.to_i
    end
  end

  def highest_bidder_name(haircut)
    highest_bid_for(haircut) ? highest_bid_for(haircut).user.name : ""
  end

  def highest_bidder_email(haircut)
    highest_bid_for(haircut) ? highest_bid_for(haircut).user.email : ""
  end

  def highest_bid_date(haircut, format = true)
    if format == true
      highest_bid_for(haircut) ? format_date_time(highest_bid_for(haircut).created_at) : ""
    else
      highest_bid_for(haircut) ? highest_bid_for(haircut).created_at.to_i : "0"
    end
  end

  def highest_bid_for(haircut)
    haircut.bids.order('amount DESC').first
  end
end
