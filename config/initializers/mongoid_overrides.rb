# Overrode mongoid array column setter to accept strings and split them
module Mongoid
  module Extensions
    module Array
      module Conversions
        extend ActiveSupport::Concern
        module ClassMethods
          def raise_or_return(value)
            unless value.nil? || value.is_a?(::String) || value.is_a?(::Array)
              raise Mongoid::Errors::InvalidType.new(::Array, value)
            end
            value.is_a?(::String) ? value.split(",") : value
          end
          alias :get :raise_or_return
          alias :set :raise_or_return
        end
      end
    end
  end
end