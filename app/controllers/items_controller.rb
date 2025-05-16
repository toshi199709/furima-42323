class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :redirect_unless_owner, only: [:edit]

  def new
    @item = Item.new
  end

  def show
  end

  def index
    @items = Item.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました'
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

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
