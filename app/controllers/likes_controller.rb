class LikesController < ApplicationController
  before_action :set_coordinate, only: [:create, :destroy]

  def create
    @like = Like.create(user_id: current_user.id, coordinate_id: params[:coordinate_id])
    @likes = Like.where(coordinate_id: params[:coordinate_id])
    @coordinate.reload
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, coordinate_id: params[:coordinate_id])
    @like.destroy
    @likes = Like.where(coordinate_id: params[:coordinate_id])
    @coordinate.reload
  end
  
  private

  def set_coordinate
    @coordinate = Coordinate.find(params[:coordinate_id])
  end

  def like_params
    params.require(:like).permit(:coordinate_id, :user_id)
  end
end
