class AddBiddingYearToBid < ActiveRecord::Migration
  def change
    add_column :bids, :bidding_year, :integer
  end
end
