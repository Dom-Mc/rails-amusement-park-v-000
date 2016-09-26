class SessionsController < ApplicationController

  def new
    authorize User
    redirect_to current_user if logged_in?
    @user = User.new
    authorize @user
  end

  def create
    authorize User
    redirect_to current_user if logged_in?
    @user = User.find_by(name: params[:user][:name])

    if @user && @user.authenticate(params[:user][:password])
      log_in @user
      redirect_to @user
    else
      flash.now[:error] = 'Invalid name/password combination'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, success: "You successfully logged out. Hope to see you back soon!"
  end

end
