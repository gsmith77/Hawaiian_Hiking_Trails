class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :name
      t.string :length
      t.string :duration
      t.string :location
      t.string :difficulty
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
