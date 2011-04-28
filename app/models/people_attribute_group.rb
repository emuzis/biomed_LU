class PeopleAttributeGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  
  field :name, :type => String
  
  embeds_many :people_attributes
  accepts_nested_attributes_for :people_attributes, :reject_if => lambda {|a| a.name.blank? || a.data_type.blank? }
  
  validates_presence_of :name
  
  search_in :name, { :allow_empty_search => true, :match => :any }
end