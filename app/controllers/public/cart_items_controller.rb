class Public::CartItemsController < ApplicationController
 before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    @cart_item = current_customer.cart_items.new(params_cart_item) #商品を新規登録
    @update_cart_item = CartItem.find_by(item: @cart_item.item) #カート内に入ってる商品データ取得
      if @update_cart_item.present? && @cart_item.valid? #一致してなければ実行
        @cart_item.amount += @update_cart_item.amount #既にカートにあった商品を新規カートに入れる
        @update_cart_item.destroy #元のカートを削除
      end

      if @cart_item.save #通常保存
        redirect_to cart_items_path #カート内アイテム一覧へ遷移
      else
        @item = Item.find(params[:cart_item][:item_id])
        @cart_item = CartItem.new
        render items_path #商品一覧へ遷移
      end
      
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount].to_i)
    flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def params_cart_item
    params.require(:cart_item).permit(:amount, :item_id)
  end

end