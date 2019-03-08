class AddAcademicFormationToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :academic_formation, :text
  end
end
