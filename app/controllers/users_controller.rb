class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  def index
    authorize User
    @users = policy_scope(User)
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      log_in @user
      redirect_to @user, success: "Welcome to the theme park!"
    else
      render :new
    end
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to @user, notice: "Your account has been updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to root_path, notice: "Your account has been deleted."
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name,
                                   :nausea,
                                   :height,
                                   :happiness,
                                   :admin,
                                   :tickets,
                                   :password)
    end
end
