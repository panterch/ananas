class RatingsController < CrudController
  belongs_to :mentor, :team, optional: true

  def index
    @events_to_rate = Event.attended_by(current_user).passed.unrated
  end

  def rating_params
    params.require(:rating).permit(
      :team_id,
      :event_id,
      :mentor_id,
      :comment,
      Rating.vote_topics.keys
    )
  end
end
