class BookmarksController < ApplicationController
  before_action :set_coordinate, only: [:create, :destroy]

  def index
    @bookmark = Bookmark.new
    @bookmarks = Bookmark.includes(:coordinate, coordinate: :user).order(created_at: "DESC").page(params[:page]).per(6)
  end

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
  
  private

  def set_coordinate
    @coordinate = Coordinate.find(params[:coordinate_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:coordinate_id, :user_id).merge(user_id: current_user.id)
  end
end
