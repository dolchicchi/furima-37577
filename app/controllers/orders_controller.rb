class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_check, only: :index
  before_action :sold_check, only: :index

  def index
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new(order_destination_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_destination_params
    params.require(:order_destination).permit(
      :post_code, :region_id, :city, :address, :building_name, :tel
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price, # 商品の値段
      card: params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def user_check
    item = Item.find(params[:item_id])
    redirect_to root_path if item.user_id == current_user.id
  end

  def sold_check
    item = Item.find(params[:item_id])
    redirect_to root_path unless item.order.nil?
  end
end
