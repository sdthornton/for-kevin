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

  def time_left_to_bid
    t = Bid.time_left
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    { time: t, seconds: ss, minutes: mm, hours: hh, days: dd }
  end

  def first_name(name)
    name.split.first
  end

  def event_date
    @system_config.close_bidding_at.strftime("%a, %B %e")
  end

  def event_year
    @system_config.close_bidding_at.year
  end
end
