class Lov
  include Mongoid::Document
  include Mongoid::Search
  field :name
  field :values
  
  validates_uniqueness_of :name
  validates_presence_of :name, :values
  
  search_in :name, :values, { :allow_empty_search => true, :match => :any }
end