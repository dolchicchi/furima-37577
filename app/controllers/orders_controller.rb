class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
  end

  def new
    
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
    Payjp.api_key = "sk_test_65764451d9433f1545387000"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,  # 商品の値段
      card: params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end