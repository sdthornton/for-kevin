class CreateSystemConfigs < ActiveRecord::Migration
  def change
    create_table :system_config do |t|
      t.column :close_bidding_at, :date
      t.timestamps null: false
    end
  end
end
