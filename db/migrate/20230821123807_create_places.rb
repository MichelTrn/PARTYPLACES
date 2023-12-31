class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.integer :price
      t.string :picture_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
