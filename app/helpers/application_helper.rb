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
  
  def sortable(title, column)
   title ||= column.titleize
   if !params[:sort].nil? && column == params[:sort][0]
     direction = sort_direction(params[:sort][1])
     klass = params[:sort][1]
   else
     direction = "asc"
     klass = ""
   end
   link_to title, {:page => 1, :sort => direction.blank? ? nil : [column, direction]}, :class => klass
  end
  
  private
  
  def sort_direction(current)
    case current
    when "asc"  then "desc"
    when "desc" then ""
    when ""     then "asc"
    end
  end
end
