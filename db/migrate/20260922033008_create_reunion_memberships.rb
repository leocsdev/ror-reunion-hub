class CreateReunionMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :reunion_memberships do |t|
      t.string :rsvp_token_digest, null: false
      t.references :person, null: false, foreign_key: true
      t.references :reunion, null: false, foreign_key: true

      t.timestamps

      # Ensure the RSVP token is unique
      t.index :rsvp_token_digest, unique: true
      # Ensure a person can only have one membership per reunion
      t.index [ :person_id, :reunion_id ], unique: true
    end
  end
end
