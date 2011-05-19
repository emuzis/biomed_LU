class UsedSampleAttributeGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :alternate_name
  field :order
  field :sample_attribute_group_id
  
  embedded_in :sample
  embeds_many :sample_attribute_values, :dependent => :destroy
  accepts_nested_attributes_for :sample_attribute_values
  belongs_to :sample_attribute_group
  
  def build_attribute_values(group)
    group.sample_attributes.each do |attr|
      sample_attribute_values.build(:label => attr.name, :data_type => attr.data_type, :lov_id => attr.lov_id)
    end
  end
  
end