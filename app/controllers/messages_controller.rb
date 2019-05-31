class MessagesController < ApplicationController
  def new
    @booking = Booking.find(params[:booking_id])
    @message = Message.new
    authorize @message
    @messages = Message.where(booking: @booking)
  end

  def create
    @messages = Message.where(booking: @booking)
    @booking = Booking.find(params[:booking_id])
    @message = Message.new(message_params)
    authorize @message
    @message.sender = current_user
    @message.booking = @booking
    @message.date = Date.today
    if @booking.user == current_user
      @message.receiver = @booking.activity.seller
    else
      @message.receiver = @booking.user
    end

    if @message.save
      @messages = Message.where(booking: @booking)
      redirect_to new_booking_message_path(@booking)
    else
      @messages = Message.where(booking: @booking)
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :likes)
  end
end
