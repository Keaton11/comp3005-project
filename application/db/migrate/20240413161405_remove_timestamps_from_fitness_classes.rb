class RemoveTimestampsFromFitnessClasses < ActiveRecord::Migration[7.1]
  def change
    remove_column :fitness_classes, :created_at, :datetime
    remove_column :fitness_classes, :updated_at, :datetime
  end
end
