class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.date :last_used
      t.date :last_maintained

      t.timestamps
    end
  end
end
