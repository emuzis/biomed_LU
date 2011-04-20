module ApplicationHelper
  def render_flash_messages
    html = ""
    [:error, :notice, :info].each do |name|
      if flash[name]
        html << %{ <div id="flash_#{name}" class="flash #{name}">#{flash[name]}</div> }
      end
    end
    html.html_safe
  end
end
