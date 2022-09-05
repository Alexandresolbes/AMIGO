class Wallet < ApplicationRecord
  belongs_to :user_trip
  has_many :bills, dependent: :destroy

  def owner
    self.user_trip.user
  end

  def balance
    if !self.bills.empty?
      credit_amount = self.bills.select { |bill| 
        !bill.credit.zero?
      }
      credit_amount = credit_amount.map { |bill|
        bill.credit
      }
      credit_amount = (credit_amount.sum / credit_amount.size.to_f)

      debit_amount = self.bills.select { |bill| 
        !bill.debit.zero?
      }
      debit_amount = debit_amount.map { |bill|
        bill.debit
      }
      debit_amount = (debit_amount.sum / debit_amount.size.to_f)
      
      if credit_amount.nil?
        return debit_amount
      elsif debit_amount.nil?
        return credit_amount
      else
        amount = (credit_amount - debit_amount)
      end
    end
  end
end
