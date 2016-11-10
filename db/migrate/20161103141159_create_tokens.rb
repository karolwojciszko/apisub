class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.references :user, foreign_key: true
      t.datetime :expired
      t.string :token

      t.timestamps
    end
  end
end
