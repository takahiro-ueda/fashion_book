class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @parents = Category.where(ancestry: nil)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email,:birth_date)
  end

end
