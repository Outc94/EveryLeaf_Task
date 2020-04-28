class UsersController < ApplicationController
  before_action :only_see_own_page, only: [:show]
  before_action :already_in, only:[:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.all
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password,
                                 :password_confirmation)
  end

  def only_see_own_page
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id), notice: "You are only allowed to view your own profile page."
    end
  end

  def already_in
   if current_user
     redirect_to tasks_path,  notice: "You can't create user when signed in unless you are an Admin (go to User Management if so)"
   end
 end

end
