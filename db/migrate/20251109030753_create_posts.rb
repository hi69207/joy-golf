class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.integer :course_id
      t.date :round_day, null: false
      t.integer :score, null: false
      t.text :sentence, null: false

      t.timestamps
    end
  end
end
