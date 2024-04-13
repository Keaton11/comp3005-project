class RemoveTimestampsFromFitnessGoals < ActiveRecord::Migration[7.1]
  def change
    remove_column :fitness_goals, :created_at, :datetime
    remove_column :fitness_goals, :updated_at, :datetime
  end
end
