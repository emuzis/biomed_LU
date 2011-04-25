class Lov
  include Mongoid::Document
  include Mongoid::Search
  field :name,           :type => String
  field :values,         :type => Array
  
  validates_uniqueness_of :name
  validates_presence_of :name, :values
  
  search_in :name, :values, { :allow_empty_search => true, :match => :any }
end