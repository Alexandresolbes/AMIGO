class WalletsController < ApplicationController
  def show
    @trip = Trip.find(params[:trip_id])
    @user_trip = UserTrip.find_by_user_id(current_user.id)
    @wallet = Wallet.find_by_user_trip_id(@user_trip)
    authorize @wallet
    @amigos = User.all.select { |u| u.id != current_user.id }
    @bills = @wallet.bills
    @bill = Bill.new
    authorize @bill
  end
end
