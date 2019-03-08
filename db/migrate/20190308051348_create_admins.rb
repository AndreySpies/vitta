class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.references :user, foreign_key: true
      t.integer :bank_code
      t.string :agency
      t.string :agency_vd
      t.string :account
      t.string :account_vd
      t.string :recipient_id
      t.string :bank_account_id

      t.timestamps
    end
  end
end
