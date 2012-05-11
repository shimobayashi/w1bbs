class SessionsController < ApplicationController
  def login
    auth = request.env['omniauth.auth']

    session[:nickname] = auth[:info][:nickname]
    logger.debug auth.to_yaml
    redirect_to root_url, :notice => 'ログインしました。'
  end

  def logout
    session[:nickname] = nil
    redirect_to root_url, :notice => 'ログアウトしました。'
  end
end
