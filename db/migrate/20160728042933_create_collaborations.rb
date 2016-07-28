class CreateCollaborations < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborations do |t|
      t.references :survey
      t.references :user
      t.integer :role

      t.timestamps
    end
  end
end
