module HaircutsHelper
  def cache_key_for_haircuts
    count = Haircut.count
    max_updated_at = Haircut.maximum(:updated_at).try(:utc).try(:to_s, :number)
    page = @page.present? && @page
    search = @search.present? && @search.downcase
    admin = current_admin.present?
    "haircuts/all-#{count}-#{max_updated_at}-page-#{page}-search-#{search}-admin-#{admin}"
  end

  def photo_url(haircut)
    if cookies[:is_retina]
      haircut.photo(:retina)
    else
      haircut.photo(:normal)
    end
  end

  def haircut_background(haircut)
    if haircut.primary_image_color.present?
      haircut.primary_image_color
    else
      "#212333"
    end
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
    # haircut.bids.order('amount DESC').first
    Bid.includes(:haircut).where(haircut_id: haircut.id).order('amount DESC').first
  end
end
