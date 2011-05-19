class UsedPeopleAttributeGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :alternate_name
  field :order
  field :people_attribute_group_id
  
  embedded_in :person
  embeds_many :people_attribute_values, :dependent => :destroy
  accepts_nested_attributes_for :people_attribute_values
  belongs_to :people_attribute_group
  
  def build_attribute_values(group)
    group.people_attributes.each do |attr|
      people_attribute_values.build(:label => attr.name, :data_type => attr.data_type, :lov_id => attr.lov_id)
    end
  end
  
end