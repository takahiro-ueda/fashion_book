class CoordinatesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_coordinate, except: [:index, :new, :create]
  before_action :set_coordinate, only: [:show, :destroy,:edit,:update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @coordinate = Coordinate.new
    @coordinates = Coordinate.includes(:user).order(created_at: "DESC").limit(9)
    @likes = Like.where(user_id: current_user)
    @like = 0
    @likes = Like.where(coordinate_id: params[:id])
  end

  def new
    @coordinate = Coordinate.new
    # @item.item_images.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    unless @coordinate.valid?
      flash.now[:alert] = @coordinate.errors.full_messages
      @coordinate.image
      render :new and return
    end
    if @coordinate.save
      redirect_to coordinates_path(id: current_user)
    else
      # @item.item_images.new
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
  end

  def destroy
    if @coordinate.destroy
      redirect_to coordinates_path, notice: '削除に成功しました。'
    else
      flash.now[:alert] = '削除に失敗しました。'
      render :edit
    end
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
      # item_images_attributes: [:src, :_destroy, :id]
      ).merge(user_id: current_user.id)
  end

  def set_coordinate
    @coordinate = Coordinate.find(params[:id])
  end

  # def set_item_images
  #   @item_images = @item.item_images
  # end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
