class ApplicationDecorator < Draper::Decorator
  def time_formatted
    created_at.strftime('%Y-%m-%d %H-%M-%S')
  end
end
