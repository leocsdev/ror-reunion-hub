class CreateReunionMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :reunion_memberships do |t|
      t.string :rsvp_token_digest
      t.references :person, null: false, foreign_key: true
      t.references :reunion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
