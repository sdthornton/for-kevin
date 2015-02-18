class RemoveVenueChangeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :venue_notice
  end
end
