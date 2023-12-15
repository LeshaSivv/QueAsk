class ApplicationDecorator < Draper::Decorator
  def time_formatted
    l created_at, format: :long
  end
end
