class AddPrimaryColorToHaircuts < ActiveRecord::Migration
  def change
    add_column :haircuts, :primary_image_color, :string
  end
end
