class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      if user.suspended
        redirect_to :back, alert: 'Your account is frozen, please contact admin'
      else
        session[:user_id] = user.id
        redirect_to user, notice: "Welcome back #{params[:username]}!"
      end
    else
      redirect_to :back, notice: 'Username or password mismatch'
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to :root
  end
end