class CreateFitnessClassMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :fitness_class_members do |t|
      t.references :fitness_class, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
