class CreateErrorApis < ActiveRecord::Migration[5.0]
  def change
    create_table :error_apis do |t|
      t.integer :number
      t.integer :status
      t.text :message

      t.timestamps
    end
  end
end
