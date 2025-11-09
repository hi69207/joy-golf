class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :name, null: false
      t.float :latitude, null: false, default: 0
      t.float :longitude, null: false, default: 0

      t.timestamps
    end
  end
end
