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

  # is the event in the past, today or in the future?
  def epoch_class(event)
    return 'today' if event.start_at.today?
    return 'past' if event.start_at < Date.today
    return 'future'
  end

  def duration_to_s(event)
    if event.start_at.to_date == event.end_at.to_date
      "%s %s - %s" % [
        event.start_at.strftime("%d.%m.%Y"),
        event.start_at.strftime("%H:%M"),
        event.end_at.strftime("%H:%M")
      ]
    else
      "%s - %s" % [
        event.start_at.strftime("%d.%m.%Y %H:%M"),
        event.end_at.strftime("%d.%m.%Y %H:%M")
      ]
    end
  end
end
