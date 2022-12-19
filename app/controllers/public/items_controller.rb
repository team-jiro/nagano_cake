class Public::ItemsController < ApplicationController
  before_action :authenticate_public!
  
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
end
