class Public::ShipsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @ship = Ship.new
    @ships = current_customer.ships
  end

  def create
    @ship = Ship.new(params[:id])
    @ship.customer_id = current_customer.id
    if @ship.update(ship_params)
      flash[:notice] = "配送先が新規登録されました。"
      redirect_to ships_path
    else
      flash[:alert] = "配送先の新規登録に失敗しました。"
      @ships = current_customer.ships
      render :index
    end
  end

  def edit
    @ship = Ship.find(params[:id])
  end

  def update
    @ship = Ship.find(params[:id])
    if @ship.update(ship_params)
      redirect_to ships_path, notice: '配送先が正常に編集されました。'
    else
      render :edit
    end
  end

  def destroy
    ship = Ship.find(params[:id])
    ship.destroy
    redirect_to ships_path, notice: '配送先が正常に削除されました。'
  end

  private
  def ship_params
    params.require(:ship).permit(:post_code, :address, :name)
  end
end
