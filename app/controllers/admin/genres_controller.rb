class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path #ジャンル一覧へ変遷
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params) #バリデーション後更新
    redirect_to admin_genres_path #ジャンル一覧へ変遷
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
