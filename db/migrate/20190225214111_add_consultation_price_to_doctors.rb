class AddConsultationPriceToDoctors < ActiveRecord::Migration[5.2]
  def change
    add_monetize :doctors, :price
  end
end
