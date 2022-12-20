class HomesController < ApplicationController
  def top
    # 新着の商品４つ
    # 販売中の商品：Item.where(is_active: true)
    # created_at順に並び替え（古い順）：sort_by{|x| x.created_at}
    # 降順（新しい順）にする：reverse
    # 前から４つだけのレコードを取り出す：[0..3]
    @new_4_items = Item.where(is_active: true).sort_by{|x| x.created_at}.reverse[0..3]
  end

  def about
  end
end
