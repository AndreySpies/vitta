class AddInformationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :profile_picture, :string, default: 'feixp6l2ixhj3u99nitt.png'
    add_column :users, :rg, :string
    add_column :users, :birth_date, :datetime
  end
end
