class AddCurrentBiddingYearToSystemConfig < ActiveRecord::Migration
  def change
    add_column :system_config, :current_bidding_year, :integer
  end
end
