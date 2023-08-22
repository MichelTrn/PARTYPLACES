class RemovePictureUrlToPlaces < ActiveRecord::Migration[7.0]
  def change
    remove_column :places, :picture_url, :string
  end
end
