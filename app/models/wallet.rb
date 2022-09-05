class Wallet < ApplicationRecord
  belongs_to :user_trip
  has_many :bills, dependent: :destroy

  def owner
    self.user_trip.user
  end

  def credit_amount(bills)
    credits_array = bills.map { |bill| bill.credit if bill.credit }
    credits_array.sum
  end

  def debit_amount(bills)
    debits_array = bills.map { |bill| bill.debit if bill.debit }
    debits_array.sum
  end

  def balance
    if self.bills.any? && credit_amount(self.bills) && debit_amount(self.bills)
      return (credit_amount(self.bills) - debit_amount(self.bills))
    else
      credit_amount(self.bills) if credit_amount(self.bills) || debit_amount(self.bills) if debit_amount(self.bills)
    end
  end

  def account(user)
    @amigo_account = self.bills.where(user_id: user)
    if @amigo_account.any?  && credit_amount(@amigo_account) && debit_amount(@amigo_account)
      return (credit_amount(@amigo_account) - debit_amount(@amigo_account))
    else
      credit_amount(@amigo_account) if credit_amount(@amigo_account) || debit_amount(@amigo_account) if debit_amount(@amigo_account)
    end
  end
end
