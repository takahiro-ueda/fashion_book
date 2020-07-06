class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    # @coordinate = Coordinate.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email,:birth_date)
  end

end
