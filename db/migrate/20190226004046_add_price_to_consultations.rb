class AddPriceToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_monetize :consultations, :price
  end
end
