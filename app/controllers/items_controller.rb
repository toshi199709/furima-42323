class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user # 出品者を紐づける

    if @item.save
      redirect_to root_path # 保存成功→トップページへ
    else
      render :new # 保存失敗→出品ページに戻る
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_status_id,
      :prefecture_id, :shipping_day_id, :price, :image
    )
  end
end
