module RatingsHelper
  def vote_as_stars(vote)
    return unless vote

    full_stars, half_star = vote.divmod(1)

    html = full_stars.times.map { '<i class="material-icons">star</i>' }

    if (half_star > 0)
      html << '<i class="material-icons">star_half</i>'
    end

    # fill up remaining empty stars
    html += (Rating::MAX_VOTE - vote.ceil).times.map { '<i class="material-icons">star_border</i>' }

    html.join.html_safe
  end
end
