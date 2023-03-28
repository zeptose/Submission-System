class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string :date_completed
      t.string :file
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
