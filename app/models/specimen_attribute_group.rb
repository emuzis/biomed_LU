class SpecimenAttributeGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  
  field :name, :type => String
  
  embeds_many :specimen_attributes, :dependent => :destroy
  accepts_nested_attributes_for :specimen_attributes, :reject_if => lambda {|a| a[:name].blank? }, :allow_destroy => true
  
  validates_presence_of :name
  
  search_in :name, {:specimen_attributes => :name}, { :allow_empty_search => true, :match => :any }
  
  def ordered_specimen_attributes
    specimen_attributes.sort!{ |a,b| (a.order||0) <=> (b.order||0) }
  end
end