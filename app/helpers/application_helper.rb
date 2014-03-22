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
end
