class PicturesController < ApplicationController

  def index
    page = !!params[:page] ? params[:page] : 1
    pics = CatPic.order_by_new.page(page).per(5)
    render json: pics
  end


end
