class AddCompetenciesToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_column :doctors, :competence, :text
  end
end
