class Sample
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  field :code
  field :alternate_code
  field :person_id
  
  attr_accessor :person_name
  
  before_validation :add_person
  
  validates_uniqueness_of :code, :alternate_code, :allow_blank => true
  validates_presence_of :code
  
  belongs_to :person
  embeds_many :used_sample_attribute_groups, :dependent => :destroy
  accepts_nested_attributes_for :used_sample_attribute_groups,
    :reject_if => lambda {|a| a[:alternate_name].blank? }, :allow_destroy => true
  
  search_in :code, :alternate_code, { :sample_attribute_values => [:label, :value] },
  { :allow_empty_search => true, :match => :any }
  
  def ordered_attribute_groups
    used_sample_attribute_groups.sort!{ |a,b| (a.order||0) <=> (b.order||0) }
  end
  
  def sample_attribute_values
    used_sample_attribute_groups.map{|p|p.sample_attribute_values}.flatten
  end
  
  private
  
  def add_person
    self.person_id = Person.where(:full_name => person_name).first.try(:id)
  end
  
end