class SessionsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:error] = "Invalid email/password combination!"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path, notice: "See you later…"
  end
end
