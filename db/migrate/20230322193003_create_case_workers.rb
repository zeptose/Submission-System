class CreateCaseWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :case_workers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :user, foreign_key: true
      t.string :phone_number

      t.timestamps
    end
  end
end
