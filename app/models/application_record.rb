class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def time_formatted
    created_at.strftime('%Y-%m-%d %H-%M-%S')
  end
end
