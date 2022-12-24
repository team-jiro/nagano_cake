class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
    @order_items.each do |order_item|
      @total += order_item.tax_included_price * order_item.amount
    end
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      flash[:notice] = "完了"
      @order.order_items.update(crafting_status: "production_pending")
    end

    if @order.status == "shipped"
      flash[:notice] = "作成完了"
    end
  		 redirect_to request.referer
  end

private

  def order_params
    params.require(:order).permit(:status)
  end

end
