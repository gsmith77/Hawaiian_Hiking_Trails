class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :length
      t.string :duration
      t.string :location
      t.string :difficulty

      t.timestamps null: false
    end
  end
end
