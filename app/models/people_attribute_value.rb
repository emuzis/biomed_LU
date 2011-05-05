class PeopleAttributeValue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :value_string
  field :value_integer
  field :value_date
  field :value_boolean
  field :used_people_attribute_group_id
  field :people_attribute_id
  
end