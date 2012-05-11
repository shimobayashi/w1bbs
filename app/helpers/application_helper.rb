module ApplicationHelper
  def current_user
    return unless session[:nickname]

    @current_user = {
      :nickname => session[:nickname],
    }
  end
end
