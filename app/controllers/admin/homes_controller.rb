class Admin::HomesController < ApplicationController
  def top
    @order = Order.find(params[:order_id])
    @customer = Customer.find(params[:customer_id])
  end
end
