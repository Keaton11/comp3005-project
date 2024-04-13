class RemoveTimestampsFromExercises < ActiveRecord::Migration[7.1]
  def change
    remove_column :exercises, :created_at, :datetime
    remove_column :exercises, :updated_at, :datetime
  end
end
