module HaircutsHelper
  def photo_url(haircut)
    if cookies[:isRetina]
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
    highest_bid_for(haircut).user.name
  end

  def highest_bidder_email(haircut)
    highest_bid_for(haircut).user.email
  end

  def format_date(date)
    date.strftime('%B %d, %Y, %I:%M%P')
  end

  private

    def highest_bid_for(haircut)
      haircut.bids.order('amount DESC').first
    end
end
