class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @booking = Booking.new(params_booking)
    authorize @booking
    @booking.activity = @activity
    @booking.user = current_user
    @booking.total_price = params[:booking][:participants_number].to_i * @activity.price
    if @booking.save
      redirect_to bookings_path
    else
      render 'activities/show'
    end
  end

  def params_booking
    params.require(:booking).permit(:user, :activity, :date, :participants_number, :status, :total_price)
  end
end
