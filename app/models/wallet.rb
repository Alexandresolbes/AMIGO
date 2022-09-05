class Wallet < ApplicationRecord
  belongs_to :user_trip
  has_many :bills, dependent: :destroy

  def owner
    self.user_trip.user
  end

  def credit_amount(credit_bills)
      credits_array = credit_bills.map { |bill| bill.credit }
      credit_amount = (credits_array.sum / credits_array.size.to_f)
  end

  def debit_amount(debit_bills)
      debits_array = debit_bills.map { |bill| bill.debit }
      debit_amount = (debits_array.sum / debits_array.size.to_f)
  end

  def balance
    if !self.bills.empty?
      credit_bills = self.bills.select { |bill| bill.credit.positive? }
      debit_bills = self.bills.select { |bill| bill.debit.positive? }
      if credit_bills.empty?
        return debit_amount(debit_bills) * -1
      elsif debit_bills.empty?
        return credit_amount(credit_bills)
      else
        return amount = (credit_amount(credit_bills) - debit_amount(debit_bills))
      end
    end
  end
end
