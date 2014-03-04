class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.references :user
      t.references :haircut

      t.timestamps
    end

    add_index :bids, :user_id
    add_index :bids, :haircut_id
  end
end
