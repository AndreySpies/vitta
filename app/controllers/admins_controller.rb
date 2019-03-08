require 'pagarme'

class AdminsController < ApplicationController
  before_action :set_admin

  def edit
    @banks = Bank.all
  end

  def update
    @admin.update(admin_params)
    @admin = create_bank_account(@admin)
    @admin = create_recipient(@admin)
    redirect_to root_path, notice: 'Suas alterações foram salvas com sucesso!'
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
    authorize @admin
  end

  def admin_params
    params.require(:admin).permit(
      :bank_code,
      :agency,
      :agency_vd,
      :account,
      :account_vd
    )
  end

  def create_bank_account(admin)
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]

    bank_account = PagarMe::BankAccount.new({
                                              bank_code: admin.bank_code,
                                              agencia: admin.agency,
                                              agencia_dv: admin.agency_vd,
                                              conta: admin.account,
                                              conta_dv: admin.account_vd,
                                              legal_name: "#{admin.user.first_name} #{admin.user.last_name}",
                                              document_number: '04499225027'
    })

    bank_account.create
    admin.update(bank_account_id: bank_account.id)
    admin
  end

  def create_recipient(admin)
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]

    recipient = PagarMe::Recipient.new({
                                         bank_account_id: admin.bank_account_id.to_s,
                                         transfer_enabled: true,
                                         transfer_interval: "daily"
    }).create
    admin.update(recipient_id: recipient.id)
    admin
  end
end
