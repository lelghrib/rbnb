class Seller::BookingsController < Seller::BaseController
  def index
    @bookings = policy_scope(Booking.select('bookings.*')
      .joins(:activity)
      .where(activities: { seller: current_user }))
  end
end
