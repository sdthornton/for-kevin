class AddVenueChangeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :venue_notice, :boolean, default: false
  end
end
