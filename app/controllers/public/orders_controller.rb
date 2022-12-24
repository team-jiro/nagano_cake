class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    cart_items = CartItem.where(customer_id: current_customer.id)
    
    if cart_items.count == 0
      redirect_to cart_items_path
    else
      @order = Order.new
    end
  end
  
  def confirm
    @cart_items = CartItem.all
    @shipping_cost = 800
    @total = 0

    @cart_items.each do |cart_item|
      @total += cart_item.sum_of_price
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

    end
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)


    @shipping_cost = 800
    @total = 0
    cart_items.each do |cart_item|
      @total += cart_item.sum_of_price
    end


    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.tax_included_price = cart.item.taxin_price
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
    @total = 0
  end


  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
    @shipping_cost = 800
    @order_items.each do |order_item|
    @total += order_item.tax_included_price * order_item.amount
    end

  end
private
  def order_params
    params.require(:order).permit(:payment_method, :shipping_postal_code, :shipping_address, :shipping_name, :billing_amount)
  end
end

