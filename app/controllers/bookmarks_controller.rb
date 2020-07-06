class BookmarksController < ApplicationController
  before_action :set_coordinate, only: [:create, :destroy]

  def index
    @bookmark = Bookmark.new
    @bookmarks = Bookmark.includes(:user, :coordinate).order(created_at: "DESC").limit(9)
    # @coordinates = Coordinate.includes(:user, :coordinat)
    # @likes = Like.where(user_id: current_user)
    # @histories = BrowsingHistory.all
    # @users = @bookmark.user_id
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
