haircut = {
  id: @haircut.id,
  name: @haircut.member,
  hash: @haircut.url,
  url: haircut_route(@haircut.url),
  post_path: haircut_bids_path(@haircut),
  photo: photo_url(@haircut),
  about_me: @haircut.about,
  highest_bid: highest_bid(@haircut)
}

bids =
  if @haircut.bids.empty?
    "No bids yet"
  else
    @haircut.bids.map do |bid| {
      id: bid.id,
      amount: bid.amount,
      bidder: {
        name: bid.user.name,
        email: bid.user.email
      },
      placed_on: format_date(bid.created_at)
    }
    end
  end

highest_bid =
  if @haircut.bids.empty?
    "No bids yet"
  else
    {
      bid: highest_bid(@haircut),
      bidder: {
        name: highest_bidder_name(@haircut),
        email: highest_bidder_email(@haircut)
      }
    }
  end

admin = {
  bids: bids,
  highest_bid: highest_bid
}

if admin_signed_in?
  { haircut: haircut,
    admin: admin,
    has_bids: @haircut.bids.present?,
    logged_in: user_signed_in? }.to_json
else
  { haircut: haircut,
    has_bids: @haircut.bids.present?,
    logged_in: user_signed_in? }.to_json
end
