{
  total_raised: bid_total,
  time_left: {
    days: sprintf('%02d',time_left_to_bid[:days]),
    hours: sprintf('%02d',time_left_to_bid[:hours]),
    minutes: sprintf('%02d',time_left_to_bid[:minutes])
  },
  unique_bids: bid_count
}.to_json
