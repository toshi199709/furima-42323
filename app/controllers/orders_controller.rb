class OrdersController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action :set_item
  before_action :set_gon_public_key, only: [:index]
  before_action :redirect_if_invalid_order, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      set_gon_public_key
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_gon_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def redirect_if_invalid_order
    redirect_to root_path if @item.order.present? || current_user == @item.user
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city,
      :address, :building, :phone_number
    ).merge(
      token: params[:token],
      item_id: @item.id,
      user_id: current_user.id
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end
end
