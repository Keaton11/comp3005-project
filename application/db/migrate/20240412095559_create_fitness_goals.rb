class CreateFitnessGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :fitness_goals do |t|
      t.references :member, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :repetitions
      t.integer :weight
      t.integer :time
      t.integer :distance

      t.timestamps
    end
  end
end
