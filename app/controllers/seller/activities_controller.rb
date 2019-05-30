class Seller::ActivitiesController < Seller::BaseController
  def index
    @activities = policy_scope(current_user.activities)

    @markers = @activities.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { activity: activity })
      }
    end
  end

  def new
    @activity = Activity.new
    authorize @activity
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.seller = current_user
    authorize @activity
    if @activity.save
      redirect_to seller_activity_path(@activity)
    else
      render :new
    end
  end
end
