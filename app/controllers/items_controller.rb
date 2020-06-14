class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  before_action :set_item, only: [:show, :destroy,:edit,:update]
  # before_action :set_item_images, only: [:edit, :update]
  # before_action :set_category, only: :new
  def index
    @items = Item.includes(:item_images).order(created_at: "DESC").limit(3)
  end

  def new
    @item = Item.new
    # @item.item_images.new
  end

  def create
    @item = Item.create(item_params)
    # unless @item.valid?
    #   flash.now[:alert] = @item.errors.full_messages
    #   @item.image
    #   render :new and return
    # end
    if @item.save
      redirect_to items_path
    else
      @item.item_images.new
      render :new
    end
    # respond_to do |format|
    #   if @item.save
    #     format.html { redirect_to @item, notice: '投稿が作成されました。' }
    #     format.json { render :show, status: :created, location: @item }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def edit
  end

  def update
    unless @item.valid?
      flash.now[:alert] = @item.errors.full_messages
      render :edit and return
    end
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit and return
    end
  end

  def show
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: '削除に成功しました。'
    else
      flash.now[:alert] = '削除に失敗しました。'
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name, 
      :introduction, 
      :category_id,
      :size_id,
      :brand,
      :season,
      :color_id,
      :price, 
      # :category_parent_id,
      # :category_root_id,
      # item_images_attributes: [:src, :_destroy, :id]
      ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  # def set_item_images
  #   @item_images = @item.item_images
  # end

  # def set_category
  #   @category = Category.all.order("id ASC").limit(13) # categoryの親を取得
  #   def category_children  
  #     @category_children = Category.find(params[:productcategory]).children 
  #   end
  #   # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
  #   def category_grandchildren
  #     @category_grandchildren = Category.find(params[:productcategory]).children
  #   end
  #   # Ajax通信で送られてきたデータをparamsで受け取り､childrenで孫を取得｡（実際には子カテゴリーの子になる｡childrenは子を取得するメソッド)
  # end
end
