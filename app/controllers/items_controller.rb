class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params_item)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def params_item
    params.require(:item).permit(
      :name, :explanation, :category_id, :status_id, :postage_id,
      :region_id, :days_required_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
