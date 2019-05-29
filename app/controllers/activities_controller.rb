class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @activities = Activity.where.not(latitude: nil, longitude: nil)

    @markers = @activities.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { activity: activity })
      }
    end

    if params[:location]
      @activities = Activity.where('address LIKE ?', params[:location])
    else
      @activities = Activity.all
    end
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.seller = current_user
    if @activity.save
      redirect_to activities_path
    else
      render :new
    end
  end

  def show
    @activity = Activity.find(params[:id])
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :address, :price, :type_activity, :description, :max_participants, :location, :latitude, :longitude)
  end
end
