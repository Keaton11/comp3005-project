class RemoveTimestampsFromFitnessClassMembers < ActiveRecord::Migration[7.1]
  def change
    remove_column :fitness_class_members, :created_at, :datetime
    remove_column :fitness_class_members, :updated_at, :datetime
  end
end
