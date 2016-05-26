module EventsHelper
  def colors(index)
    # The base color has no additional class
    colors = ['color-1', 'color-2', 'color-3', 'color-4']
    colors[index % colors.length]
  end

  def state_color(state)
    case state
    when 'invited'
      'grey lighten-2'
    when 'attending'
      'green'
    when 'declined'
      'red'
    end
  end

  def state_icon(state)
    case state
    when 'invited'
      'help'
    when 'attending'
      'event_available'
    when 'declined'
      'event_busy'
    end
  end

  def vote_as_stars(vote)
    full_stars, half_star = vote.divmod(1)

    html = full_stars.times.map { '<i class="material-icons">star</i>' }

    if (half_star > 0)
      html << '<i class="material-icons">star_half</i>'
    end

    html.join.html_safe
  end
end
