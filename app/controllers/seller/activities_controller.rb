class Seller::ActivitiesController < Seller::BaseController
  def index
    @activities = policy_scope(current_user.activities)
  end
end
