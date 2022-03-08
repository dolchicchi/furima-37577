class ItemsController < ApplicationController
  def index
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

  private
  def params_item
    params.require(:item).permit(
      :name, :explanation, :category_id, :status_id,
      :postage_id, :region_id, :days_required_id, :price
    ).merge(user_id: current_user.id)
  end
end
