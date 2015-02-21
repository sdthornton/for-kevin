namespace :oneoff do
  task set_previous_bids_to_2014: :environment do
    Bid.find_each do |bid|
      bid.bidding_year = 2014
      bid.save!
    end
  end
end
