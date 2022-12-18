class Admin::HomesController < ApplicationController
  def top
    @order = Order.find(params[:order_id])
  end
end
