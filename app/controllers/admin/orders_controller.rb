class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
    @order_items.each do |order_item|
      @total += order_item.item.add_tax_price * order_item.amount
    end
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    if @order.status == "payment_cofirm"
      flash[:notice] = "作り始めよう！"
      @order.order_items.update(making_status: "waiting")
    end

    if @order.status == "shipped"
      flash[:notice] = "頑張ったね！"
    end
    redirect_to request.referer
  end
  
private
  def order_params
    params.require(:order).permit(:status)
  end

end
