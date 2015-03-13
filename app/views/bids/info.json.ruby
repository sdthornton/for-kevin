{
  total_raised: bid_total,
  time_left: {
    days: sprintf('%02d', @time_left[:days]),
    hours: sprintf('%02d', @time_left[:hours]),
    minutes: sprintf('%02d', @time_left[:minutes])
  },
  unique_bids: bid_count
}.to_json
