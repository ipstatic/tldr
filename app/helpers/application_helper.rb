module ApplicationHelper
  def nav_link_to(text, path)
    class_name = current_page?(path) ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to text, path
    end
  end

  def host_state(state)
    case state
    when 0
      html_class = 'success'
      text = 'UP'
    when 1
      html_class = 'danger'
      text = 'DOWN'
    when 2
      html_class = 'warning'
      text = 'UNREACHABLE'
    end
    content_tag(:span, text, class: "label label-#{html_class}")
  end

  def service_state(state)
    case state
    when 0
      html_class = 'success'
      text = 'OK'
    when 1
      html_class = 'warning'
      text = 'WARNING'
    when 2
      html_class = 'danger'
      text = 'CRITICAL'
    when 3
      html_class = 'default'
      text = 'UNKNOWN'
    end
    content_tag(:span, text, class: "label label-#{html_class}")
  end

  def on_off_state(state)
    case state
    when 0
      html_class = 'danger'
      text = 'NO'
    when 1
      html_class = 'success'
      text = 'YES'
    end
    content_tag(:span, text, class: "label label-#{html_class}")
  end

  def to_time(timestamp)
    if timestamp == 0
      'Never'
    else
      Time.zone.at(timestamp).to_s(:long_ordinal)
    end
  end
end
