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

  def time_left_formatted
    "<span class='time-left time-left--days'>
      #{sprintf('%02d',time_left_to_bid[:days])}
    </span>
    <span class='time-left-separator'>:</span>
    <span class='time-left time-left--hours'>
      #{sprintf('%02d',time_left_to_bid[:hours])}
    </span>
    <span class='time-left-separator'>:</span>
    <span class='time-left time-left--minutes'>
      #{sprintf('%02d',time_left_to_bid[:minutes])}
    </span>".html_safe
  end

  def first_name(name)
    name.split.first
  end
end
