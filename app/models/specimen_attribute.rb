class SpecimenAttribute
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name,           :type => String
  field :data_type,      :type => String
  field :order,          :type => Integer
  field :lov_id,         :type => Integer
  
  belongs_to :lov
  embedded_in :specimen_attribute_group
  
  DATA_TYPES = [
    { :value => "string",  :text => "Teksts",   :method => :value_string },
    { :value => "integer", :text => "Skaitlis", :method => :value_integer },
    { :value => "date",    :text => "Datums",   :method => :value_date },
    { :value => "boolean", :text => "Pazīme",   :method => :value_boolean }
  ]
  
  before_save :remove_data_type

  # def value
  #   method = DATA_TYPES.find{|v| v[:name] == data_type }[:method]
  #   people_attribute_value.try(method)
  # end
  
  private
  
  def remove_data_type
    unless lov_id.blank?
      self.data_type = nil
    end
  end
  
end