class CreateReunions < ActiveRecord::Migration[8.1]
  def change
    create_table :reunions do |t|
      t.string :name, null: false
      t.date :event_date, null: false

      t.timestamps
    end
  end
end
