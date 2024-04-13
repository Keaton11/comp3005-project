class RemoveTimestampsFromFitnessClassEquipments < ActiveRecord::Migration[7.1]
  def change
    remove_column :fitness_class_equipments, :created_at, :datetime
    remove_column :fitness_class_equipments, :updated_at, :datetime
  end
end
