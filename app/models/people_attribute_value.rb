class PeopleAttributeValue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :value
  field :label
  
  embedded_in :used_people_attribute_group
  
end