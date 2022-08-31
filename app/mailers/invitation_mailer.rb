class InvitationMailer < ApplicationMailer
  default from: 'noreply@amigo-trips.com'

  def invitation_email
    @address = params[:address]
    @user = params[:user]
    @trip = params[:trip]

    mail(to: @address, subject: "#{@user.first_name} wants to go to #{@trip.destination} with you!")
  end
end
