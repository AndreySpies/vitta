class AddCoordinatesToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :latitude, :float
    add_column :doctors, :longitude, :float
  end
end
