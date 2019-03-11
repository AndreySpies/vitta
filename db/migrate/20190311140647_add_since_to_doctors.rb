class AddSinceToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :since, :integer
  end
end
