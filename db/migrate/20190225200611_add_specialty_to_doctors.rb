class AddSpecialtyToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_reference :doctors, :specialty, foreign_key: true
  end
end
