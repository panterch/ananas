class RatingsController < CrudController
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
