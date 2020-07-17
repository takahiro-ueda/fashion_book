class CategoriesController < ApplicationController

  def show
    @parents = Category.where(ancestry: nil)
    # Categoryのデータベースのテーブルから一致するidを取得
    @category = Category.find(params[:id])
    # category_idと紐づく投稿を取得
    @items = @category.items.order(created_at: :desc).page(params[:page]).per(9)
    
  end
end
