class CreateParents < ActiveRecord::Migration[5.2]
  def change
    create_table :parents do |t|
      t.string :p1_first_name
      t.string :p1_last_name
      t.string :p2_first_name
      t.string :p2_last_name
      t.string :email
      t.string :phone_number
      t.references :user, foreign_key: true
      t.boolean :active, default: true
      t.integer :open_beds
      t.string :family_style

      t.timestamps
    end
  end
end
