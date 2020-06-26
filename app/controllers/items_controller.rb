class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, except: [:index, :new, :create]
  before_action :set_item, only: [:show, :destroy,:edit,:update]
  # before_action :set_size, except: [:index, :new, :create]
  # before_action :set_size, only: [:show, :destroy,:edit,:update]
  before_action :move_to_index, except: [:index, :show]
  # before_action :set_item_images, only: [:edit, :update]
  before_action :set_category, only: :new


  def index
    @item = Item.new
    @items = Item.includes(:user).order(created_at: "DESC").limit(9)
    
  end

  def new
    @item = Item.new
    # @item.item_images.new
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @item = Item.new(item_params)
    category = Category.find(item_params[:category_id])
    # size = ItemsSize.find(size_params[:category_size_id])
    @item = category.items.create(item_params)
    unless @item.valid?
      flash.now[:alert] = @item.errors.full_messages
      @item.image
      render :new and return
    end
    if @item.save
      redirect_to items_path(id: current_user)
    else
      # @item.item_images.new
      render :new
    end
  end

  def edit
    # #カテゴリーデータ取得
    # @category_grandchildren = @item.category
    # @category_children = @category_grandchildren.parent 
    # @category_parent = @category_children.parent

    # #カテゴリー一覧を作成
    # @category = Category.find(params[:id])
    # # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
    # @category_children = @item.category.parent.parent.children
    # # 紐づく孫カテゴリーの一覧を配列で取得
    # @category_grandchildren = @item.category.parent.children
  end

  def update
    unless @item.valid?
      flash.now[:alert] = @item.errors.full_messages
      render :edit and return
    end
    if @item.update(item_params)
      redirect_to items_path
    else
      render :edit and return
    end
  end

  def show
    @size = @item.items_size_id
    @brand = @item.brand
    @season = @item.season
    @color = @item.color
    @category = @item.category
   
  end

  def destroy
    if @item.destroy
      redirect_to items_path, notice: '削除に成功しました。'
    else
      flash.now[:alert] = '削除に失敗しました。'
      render :edit
    end
  end


  private

  def set_category  
    # @parents = Category.where(ancestry: nil)
    # @category = Category.all.order("id ASC").limit(8) # categoryの親を取得
    def category_children 
      respond_to do |format| 
        format.html
        format.json do
          @category_children = Category.find(params[:parent_name]).children
        end
      end
    end
    # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
    def category_grandchildren
      respond_to do |format| 
        format.html
        format.json do
          @category_grandchildren = Category.find("#{params[:child_id]}").children
        end
      end
    end
    # Ajax通信で送られてきたデータをparamsで受け取り､childrenで孫を取得｡（実際には子カテゴリーの子になる｡childrenは子を取得するメソッド)
  
    # 孫カテゴリーが選択された後に動くアクション
    def category_size
      @category_grandchildren = Category.find("#{params[:grandchild_id]}").children #孫カテゴリーを取得
      if related_size_parent = @category_grandchildren.items_sizes[0] #孫カテゴリーと紐付くサイズ（親）があれば取得
        @category_size = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
      else
        @category_grandchildren = Category.find("#{params[:grandchild_id]}").parent #孫カテゴリーの親を取得
        if related_size_parent = @category_grandchildren.items_sizes[0] #孫カテゴリーの親と紐付くサイズ（親）があれば取得
          @category_size = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
        end
      end
    end
  end

  def item_params
    params.require(:item).permit(
      :image,
      :name, 
      :introduction, 
      :category_id,
      :items_size_id,
      :brand_id,
      :season_id,
      :color_id,
      :price, 
      :category_children_id,
      :category_grandchildren_id,
      # :category_size_id
      # item_images_attributes: [:src, :_destroy, :id]
      ).merge(user_id: current_user.id)
  end

  # def size_params
  #   params.require(:items_size).permit(:category_id, :items_size_id)
  # end

  # def set_size
  #   @size = ItemsSize.find(params[:id])
  # end

  def set_item
    @item = Item.find(params[:id])
  end

  # def set_item_images
  #   @item_images = @item.item_images
  # end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
