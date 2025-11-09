class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.integer :prefecture_id
      t.string :name, null: false
      t.string :address, null: false
      t.float :latitude, null: false, default: 0
      t.float :longitude, null: false, default: 0
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
