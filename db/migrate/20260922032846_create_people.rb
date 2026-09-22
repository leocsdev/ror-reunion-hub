class CreatePeople < ActiveRecord::Migration[8.1]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :maiden_name
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
