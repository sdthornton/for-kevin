class CreateHaircuts < ActiveRecord::Migration
  def change
    create_table :haircuts do |t|
      t.string :member
      t.text :about
      t.string :url

      t.timestamps
    end

    add_index :haircuts, :url, unique: true
  end
end
