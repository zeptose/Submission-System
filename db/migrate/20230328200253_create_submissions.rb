class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.date :date_completed
      t.string :filename
      t.string :file
      t.references :assignment, foreign_key: true

      t.timestamps
    end
  end
end
