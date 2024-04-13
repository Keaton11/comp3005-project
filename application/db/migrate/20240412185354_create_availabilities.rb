class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.time :start_time
      t.time :end_time
      t.references :trainer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
