class SampleAttribute
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :data_type
  field :order
  field :lov_id
  
  belongs_to :lov
  embedded_in :sample_attribute_group
  
  DATA_TYPES = [
    { :value => "string",  :text => "Teksts",   :method => :value_string },
    { :value => "integer", :text => "Skaitlis", :method => :value_integer },
    { :value => "date",    :text => "Datums",   :method => :value_date },
    { :value => "boolean", :text => "Pazīme",   :method => :value_boolean }
  ]
  
  before_save :remove_data_type
  
  private
  
  def remove_data_type
    self.data_type = nil unless lov_id.blank?
  end
  
end