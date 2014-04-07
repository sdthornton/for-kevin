class AddPrimaryToHaircuts < ActiveRecord::Migration
  def change
    add_column :haircuts, :primary, :boolean, default: false
  end
end
