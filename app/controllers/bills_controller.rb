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
    if @bill.save!
      create_notification("created", @wallet, @bill)
      redirect_to trip_wallet_path(@trip, @wallet), notice: "Bill created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @wallet = @bill.wallet_id
    authorize @bill
    @bill.destroy
    redirect_to trip_wallet_path(@trip, @wallet), status: :see_other
  end

  private

  def bill_params
    params.require(:bill).permit(:debit, :credit, :paid, :user_id)
  end

  def create_notification(action, wallet, bill)
    @trip = Trip.find(params[:trip_id])
    @notification = Notification.new(content: "A bill was #{action} for #{wallet.owner.first_name} and #{User.find(bill.user_id).first_name}")
    @notification.user_id = wallet.owner.id
    @notification.trip_id = @trip.id
    @notification.save!
  end
end
