module EventsHelper
  def colors(index)
    # The base color has no additional class
    colors = ['darken-4', 'darken-3', 'darken-2', 'darken-1', '',
              'lighten-1', 'lighten-2', 'lighten-3', 'lighten-4',
              'lighten-5', 'lighten-4', 'lighten-3', 'lighten-2',
              'lighten-1', '', 'darken-1', 'darken-2', 'darken-3']
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
end
