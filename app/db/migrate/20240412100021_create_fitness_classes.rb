class CreateFitnessClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :fitness_classes do |t|
      t.references :room, null: false, foreign_key: true
      t.references :trainer, null: false, foreign_key: true
      t.boolean :group_session, default: false
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
