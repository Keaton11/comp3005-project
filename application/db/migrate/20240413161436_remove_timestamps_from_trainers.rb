class RemoveTimestampsFromTrainers < ActiveRecord::Migration[7.1]
  def change
    remove_column :trainers, :created_at, :datetime
    remove_column :trainers, :updated_at, :datetime
  end
end
