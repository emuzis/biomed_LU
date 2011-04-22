class Lov
  include Mongoid::Document
  field :name,           :type => String
  field :values,         :type => Array
  
  validates_uniqueness_of :name
  validates_presence_of :name, :values
end