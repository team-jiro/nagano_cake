class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.page(params[:page]).per(7) #1ページ7件表示
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_index_path #ジャンル一覧へ変遷
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params) #バリデーション後更新
    redirect_to admin_genres_index_path #ジャンル一覧へ変遷
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
