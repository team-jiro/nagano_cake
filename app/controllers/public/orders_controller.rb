class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  def confirm
    @cart_items = CartItem.all
    @shipping_cost = 800
    @billing_amount = 0

    @cart_items.each do |cart_item|
      @billing_amount += cart_item.subtotal
    end

    if params[:order][:selected_address] == "1"
      @order = Order.new(order_params)
      @order.shipping_postal_code = current_customer.post_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.full_name

    elsif params[:order][:selected_address] == "2"

      @order = Order.new(order_params)
      @address = Ship.find(params[:order][:customer_id])
      @order.shipping_postal_code = @address.post_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name

    elsif params[:order][:selected_address] == "3"

      @order = Order.new(order_params)
      # @order.post_code = @address.post_code
      # @order.address = @address.address
      # @order.name = @address.name
    end
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)


    @shipping_cost = 800
    @billing_amount = 0
    cart_items.each do |cart_item|
      @billing_amount += cart_item.subtotal
    end

    @order.postage = @shipping_cost
    @order.total_price = @billing_amount

    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.price = cart.item.add_tax_price
        order_item.save
      end
       redirect_to complete_orders_path
       cart_items.destroy_all
    else
      flash[:alert] = "住所を記載してください"
      render :new

    end
  end

  def complete
  end


  def index
    @orders = Order.where(customer_id: current_customer.id)
  end


  def show
    @order = Order.find(params[:id])
    @orders = OrderItem.find(params[:id])
  end
private
  def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_address, :shipping_name)
  end
end

