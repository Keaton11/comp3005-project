class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.boolean :has_weight, default: false
      t.boolean :has_time, default: false
      t.boolean :has_distance, default: false

      t.timestamps
    end
  end
end
