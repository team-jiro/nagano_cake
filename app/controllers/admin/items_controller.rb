class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @item = Item.new
    @items = Item.all
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = " 作成されました。"
      redirect_to admin_item_path(@item.id)
    else
      flash[:alert] = "エラーが発生しました。"
      render :new
    end
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @genre = Genre.all
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    flash[:notice] = "編集完了。"
    redirect_to admin_item_path(item.id)
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :genre_id, :is_active)
  end

end