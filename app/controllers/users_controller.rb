class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit,:profile,:profile_update, :destroy]
  before_action :set_address, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to edit_user_path(@address)
    else
      render :edit
    end
  end

  def destroy 
    @user.destroy
    redirect_to("/")
  end

  def profile   
  end

  def profile_update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :profile
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email,:birth_date)
  end

  def address_params
    params.require(:address).permit(
      :family_name,
      :first_name,
      :family_name_kana,
      :first_name_kana,
      :prefecture_id,
      :zip_code,
      :municipality,
      :address,
    ).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
