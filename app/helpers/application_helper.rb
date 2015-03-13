module ApplicationHelper
  def format_date(date)
    date.strftime('%m/%d/%y')
  end

  def format_date_time(date)
    date.strftime('%m/%d/%y, %I:%M%P')
  end

  def bidding_is_open?
    Bid.open
  end

  def first_name(name)
    name.split.first
  end

  def event_date
    SystemConfig.close_bidding_at.strftime("%a, %B %e")
  end

  def event_year
    SystemConfig.close_bidding_at.year
  end
end
