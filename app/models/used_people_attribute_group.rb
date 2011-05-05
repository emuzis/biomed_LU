class UsedPeopleAttributeGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :alternate_name
  field :order
  field :people_attribute_group_id
  
  embedded_in :person
  belongs_to :people_attribute_group
end