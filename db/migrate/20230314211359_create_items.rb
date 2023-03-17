class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :instructions
      t.string :file
      t.string :due_date
      t.boolean :active
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
