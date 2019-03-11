require 'pagarme'

class Admin < ApplicationRecord
  belongs_to :user

  after_validation :create_bank_account, :create_recipient

  private

  def create_bank_account
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]

    bank_account = PagarMe::BankAccount.new({
                                              bank_code: self.bank_code,
                                              agencia: self.agency,
                                              agencia_dv: self.agency_vd,
                                              conta: self.account,
                                              conta_dv: self.account_vd,
                                              legal_name: "#{self.user.first_name} #{self.user.last_name}",
                                              document_number: '04499225027'
    })

    bank_account.create
    self.bank_account_id = bank_account.id
    self
  end

  def create_recipient
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]

    recipient = PagarMe::Recipient.new({
                                         bank_account_id: self.bank_account_id.to_s,
                                         transfer_enabled: true,
                                         transfer_interval: "daily"
    }).create
    self.recipient_id = recipient.id
    self
  end
end
