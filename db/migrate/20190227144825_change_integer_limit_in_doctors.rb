class ChangeIntegerLimitInDoctors < ActiveRecord::Migration[5.2]
  def change
    change_column :doctors, :crm, :integer, limit: 8
  end
end
