class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.date :date
      t.string :title
      t.integer :amount
      t.timestamps null: false
    end
  end
end
