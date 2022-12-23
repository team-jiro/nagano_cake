class SearchesController < ApplicationController
  def search
    @word = params[:word]
    @items = Item.where("name LIKE?", "%#{@word}%")
  end
end
