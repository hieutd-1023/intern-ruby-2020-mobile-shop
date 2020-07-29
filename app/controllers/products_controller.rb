class ProductsController < ApplicationController
  def index
    @categories = Category.active_status
    @brands = Brand.active_status
    @products = Product.by_name(params[:keyword])
                       .by_brand(params[:brand])
                       .includes(:images)
                       .page(params[:page])
                       .per(Settings.per_page)
  end
end
