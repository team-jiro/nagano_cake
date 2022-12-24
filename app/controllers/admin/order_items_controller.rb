class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id]) #当該注文商品特定
		@order_item.update(order_item_params) #バリデーション後更新
		@order = @order_item.order #アソシエーションで注文テーブル呼び出し

    if @order_item.crafting_status == "in_production" #製作ステータス「製作中」時は↓
		  @order.update(status: 2) #注文ステータスも「製作中」に更新

    	#↓全商品の個数と製作ステータス内「製作完了」商品数が一致で、製作ステータスを「製作完了」に更新
    elsif @order.order_items.count ==  @order.order_items.where(crafting_status: "production_complete").count
		  @order.update(status: 3) #「製作完了」と同時に注文ステータスを「発送準備中」に更新
    end
	    redirect_to admin_order_path(@order) #注文詳細に遷移
  end

  private

  def order_item_params
    params.require(:order_item).permit(:amount, :tax_included_price, :crafting_status)
  end
end


