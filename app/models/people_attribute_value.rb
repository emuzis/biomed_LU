class PeopleAttributeValue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :value_string,       :type => String
  field :value_integer,      :type => String
  field :value_date,         :type => Date
  field :value_boolean,      :type => Boolean
  
end