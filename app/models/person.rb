class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  field :first_name
  field :last_name
  field :full_name
  field :date_of_birth
  field :diagnosed_at
  field :age_at_diagnosis
  field :alive_flag
  field :social_number
  field :control_flag
  
  validate :validate_date_correctivness, :validate_numericality
  validates_uniqueness_of :social_number
  validates_presence_of :first_name, :last_name, :date_of_birth, :social_number
  
  before_save :add_full_name
  
  embeds_many :used_people_attribute_groups, :dependent => :destroy
  accepts_nested_attributes_for :used_people_attribute_groups,
    :reject_if => lambda {|a| a[:alternate_name].blank? }, :allow_destroy => true
  
  search_in :first_name, :last_name, { :people_attribute_values => [:label, :value] },
  { :allow_empty_search => true, :match => :any }
  
  def ordered_attribute_groups
    used_people_attribute_groups.sort!{ |a,b| (a.order||0) <=> (b.order||0) }
  end
  
  def people_attribute_values
    used_people_attribute_groups.map{|p|p.people_attribute_values}.flatten
  end
  
  private
  
  def add_full_name
    self.full_name = "#{first_name} #{last_name}"
  end
  
  def validate_date_correctivness
    if (!date_of_birth.blank? && (Date.parse(date_of_birth) rescue ArgumentError) == ArgumentError)
      errors.add(:date_of_birth, "ir nekorekts datums")
    end
    if (!diagnosed_at.blank? && (Date.parse(diagnosed_at) rescue ArgumentError) == ArgumentError)
      errors.add(:diagnosed_at, "ir nekorekts datums")
    end
  end
  
  def validate_numericality
    if (!age_at_diagnosis.blank? && (Integer(age_at_diagnosis) rescue ArgumentError) == ArgumentError)
      errors.add(:age_at_diagnosis, "nav skaitlis")
    end
  end
  
end