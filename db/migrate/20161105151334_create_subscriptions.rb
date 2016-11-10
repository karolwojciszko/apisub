class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :channel, foreign_key: true
      t.references :show, foreign_key: true

      t.timestamps
    end
  end
end
