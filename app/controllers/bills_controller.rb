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
    @amigos = @trip.users
    if @bill.save
      generate_counter_bill
      redirect_to trip_wallet_path(@trip, @wallet), notice: "Bill created!"
    else
      flash[:alert] = "Error! Looks like some details are missing in your bill."
      render partial: "bills/form", :locals => { trip: @trip, wallet: @wallet }
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

  def generate_counter_bill
    bill = Bill.new
    bill.user_id = @bill.wallet.user_trip.user_id
    bill.credit = @bill.debit if @bill.debit
    bill.debit = @bill.credit if @bill.credit
    bill.wallet_id = UserTrip.find_by(user_id: @bill.user_id, trip_id: @trip.id).wallet.id
    bill.save!
  end

  def bill_params
    params.require(:bill).permit(:debit, :credit, :paid, :user_id)
  end

end
