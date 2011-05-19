class SampleAttributeValue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :value
  field :label
  field :data_type
  field :lov_id
  
  embedded_in :used_sample_attribute_group
  
end