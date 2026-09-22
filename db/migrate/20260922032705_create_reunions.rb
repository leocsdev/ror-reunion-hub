class CreateReunions < ActiveRecord::Migration[8.1]
  def change
    create_table :reunions do |t|
      t.string :name
      t.date :event_date

      t.timestamps
    end
  end
end
