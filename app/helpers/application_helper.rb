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
  
  def sortable(title, column, controller, params)
   title ||= column.titleize
   if !params[:sort].nil? && column == params[:sort][0]
     direction = sort_direction(params[:sort][1])
     klass = params[:sort][1]
   else
     direction = "asc"
     klass = ""
   end
   link_to title, {:search => params[:search], :controller => controller, :page => 1,
     :sort => direction.blank? ? nil : [column, direction]}, :class => klass
  end
  
  def custom_error_messages_for(records, options={})
    error_messages = parse_error_messages(records, options)
    if error_messages.present?
      html = "<ul>"
      error_messages.each do |msg, attrs|
        error_message = "#{attrs.sort.to_sentence(:last_word_connector => " un ")} #{msg}"
        html << "<li>#{error_message}</li>"
      end
      html << "</ul>"
      html.html_safe
    end
  end
  
  private
  
  def sort_direction(current)
    case current
    when "asc"  then "desc"
    when "desc" then ""
    when ""     then "asc"
    end
  end
  
  def parse_error_messages(records, options={})
    errors = {}
    errors_method = options[:errors_method] || :errors
    records.each do |record|
      record.send(errors_method).each do |attr, msg|
        next if !options[:include_associations] && record.class.respond_to?(:reflections) && record.class.reflections.keys.include?(attr)
        next if msg.blank?
        errors[msg] ||= []
         human_attr = record.class.human_attribute_name(attr.to_s)
        key = "<strong>#{human_attr}</strong>"
        key = "" if attr.to_s == "base" || human_attr.blank?
        errors[msg] << key unless errors[msg].include?(key)
      end
    end
    errors
  end
  
end
