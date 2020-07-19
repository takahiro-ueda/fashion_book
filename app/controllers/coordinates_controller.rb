class CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :history]
  before_action :set_coordinate, except: [:index, :new, :create]
  before_action :set_coordinate, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, except: [:index, :show, :history]

  def index
    @coordinate = Coordinate.new
    @coordinates = Coordinate.includes(:user).order(created_at: "DESC").page(params[:page]).per(9)
    @likes = Like.where(user_id: current_user)
    @bookmarks = Bookmark.where(user_id: current_user)
  end

  def new
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    if user_signed_in?
      @coordinate.user_id = current_user.id
    end
    unless @coordinate.valid?
      flash.now[:alert] = @coordinate.errors.full_messages
      @coordinate.image
      render :new and return
    end
    if @coordinate.save
      redirect_to coordinates_path(id: current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    unless @coordinate.valid?
      flash.now[:alert] = @coordinate.errors.full_messages
      render :edit and return
    end
    if @coordinate.update(coordinate_params)
      redirect_to coordinates_path
    else
      render :edit and return
    end
  end

  def show
    @gender = @coordinate.gender
    @height = @coordinate.height
    @age = @coordinate.age
    @month = @coordinate.month
    @hairstyle = @coordinate.hairstyle
    @comment = Comment.new
    #新着順で表示
    @comments = @coordinate.comments.includes(:user).order(created_at: :desc)
    @like = 0
    @likes = Like.where(coordinate_id: params[:id])
    @bookmark = 0
    @bookmarks = Bookmark.where(coordinate_id: params[:id])

    new_history = @coordinate.browsing_histories.new
    new_history.user_id = current_user.id
    if current_user.browsing_histories.exists?(coordinate_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(coordinate_id: "#{params[:id]}")
      old_history.destroy
    end
    new_history.save
    histories_stock_limit = 9
    histories = current_user.browsing_histories.all
    if histories.count > histories_stock_limit
      histories[0].destroy
    end
  end

  def destroy
    if @coordinate.destroy
      redirect_to coordinates_path, notice: '削除に成功しました。'
    else
      flash.now[:alert] = '削除に失敗しました。'
      render :edit
    end
  end

  def history
    @histories = BrowsingHistory.includes(:coordinate, coordinate: :user).order(created_at: "DESC")
    @coordinate = Coordinate.all
  end

  private

  def coordinate_params
    params.require(:coordinate).permit(
      :image, 
      :name,
      :introduction, 
      :gender_id,
      :height_id,
      :age_id,
      :month_id,
      :hairstyle_id, 
      ).merge(user_id: current_user.id)
  end

  def set_coordinate
    @coordinate = Coordinate.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
