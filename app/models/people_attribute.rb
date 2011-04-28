class PeopleAttribute
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name,           :type => String
  field :data_type,      :type => String
  field :order,          :type => Integer
  
  DATA_TYPES = [
    { :value => "string",  :text => "Teksts",   :method => :value_string },
    { :value => "integer", :text => "Skaitlis", :method => :value_integer },
    { :value => "date",    :text => "Datums",   :method => :value_date },
    { :value => "boolean", :text => "Pazīme",   :method => :value_boolean }
  ]

  def value
    method = DATA_TYPES.find{|v| v[:name] == data_type }[:method]
    people_attribute_value.try(method)
  end
  
end