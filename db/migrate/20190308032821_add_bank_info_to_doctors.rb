class AddBankInfoToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :bank_code, :integer
    add_column :doctors, :agency, :string
    add_column :doctors, :agency_vd, :string
    add_column :doctors, :account, :string
    add_column :doctors, :account_vd, :string
    add_column :doctors, :recipient_id, :string
    add_column :doctors, :bank_account_id, :integer
    add_column :doctors, :status, :string
  end
end
