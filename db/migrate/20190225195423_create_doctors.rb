class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.string :address
      t.text :description
      t.integer :crm

      t.timestamps
    end
  end
end
