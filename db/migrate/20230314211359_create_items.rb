class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :instructions
      t.string :filename
      t.string :file
      t.string :due_date
      t.boolean :active, default: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
