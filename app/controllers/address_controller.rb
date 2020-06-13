class AddressController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @prefecture = @address.prefecture
    @user = @address.user
    @addresses = Address.all
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to user_path(@address)
      # redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = '編集に失敗しました。'
      render :edit
    end
  end

  private

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

  def set_address
    @address = Address.find(params[:id])
  end
end
