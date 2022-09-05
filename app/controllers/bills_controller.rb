class BillsController < ApplicationController

  def create
    @trip = Trip.find(params[:trip_id])
    authorize @trip
    @wallet = Wallet.find(params[:wallet_id])
    authorize @wallet
    @bill = Bill.new(bill_params)
    authorize @bill
    @bill.wallet_id = @wallet.id
    @bill.paid = false
    @bill.wallet_id = @wallet.id
    if @bill.save!
      amigo_bill(@bill).save!
      redirect_to trip_wallet_path(@trip, @wallet), notice: "Bill created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bill = Bill.find(params[:id])
    authorize @bill
    @wallet = @bill.wallet_id
    @trip = Trip.find(params[:trip_id])
    @bill.destroy
    redirect_to trip_wallet_path(@trip, @wallet), status: :see_other
  end

  private

  def amigo_bill(bill)
    @amigo_bill = Bill.new(bill_params)
    
    @amigo_bill.debit = bill.credit if !bill.debit
    @amigo_bill.credit = bill.debit if !bill.credit

    @amigo_bill.wallet_id = bill.user_id

    @amigo_bill.user_id = bill.wallet_id

    @amigo_bill
  end

  def bill_params
    params.require(:bill).permit(:debit, :credit, :paid, :user_id)
  end

end
