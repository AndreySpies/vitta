class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :doctor, foreign_key: true
      t.references :patient, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
