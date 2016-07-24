class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.references :survey, foreign_key: true
      t.string :ip

      t.timestamps
    end
  end
end
