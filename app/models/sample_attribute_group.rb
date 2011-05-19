class SampleAttributeGroup
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  
  default_scope :order => "name asc"
  
  field :name
  
  embeds_many :sample_attributes, :dependent => :destroy
  accepts_nested_attributes_for :sample_attributes, :reject_if => lambda {|a| a[:name].blank? }, :allow_destroy => true
  
  validates_presence_of :name
  
  search_in :name, { :sample_attributes => :name }, { :allow_empty_search => true, :match => :any }
  
  def ordered_sample_attributes
    sample_attributes.sort!{ |a,b| (a.order||0) <=> (b.order||0) }
  end
end