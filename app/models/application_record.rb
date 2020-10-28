# frozen_string_literal: true

# Main base class for all ActiveRecord::Base classes in your application
# Rails convention that avoids the need to monkey patch ActiveRecord::Base
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
