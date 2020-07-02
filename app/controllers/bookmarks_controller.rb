class BookmarksController < ApplicationController
  before_action :set_coordinate, only: [:create, :destroy, :show]

  def create
    @bookmark = Bookmark.create(user_id: current_user.id, coordinate_id: params[:coordinate_id])
    @bookmarks = Bookmark.where(coordinate_id: params[:coordinate_id])
    @coordinate.reload
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, coordinate_id: params[:coordinate_id])
    @bookmark.destroy
    @bookmarks = Bookmark.where(coordinate_id: params[:coordinate_id])
    @coordinate.reload
  end

  def show
    @bookmarks = current_user.bookmark_coordinates.includes(:user)
  end
  
  private

  def set_coordinate
    @coordinate = Coordinate.find(params[:coordinate_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:coordinate_id, :user_id)
  end
end
