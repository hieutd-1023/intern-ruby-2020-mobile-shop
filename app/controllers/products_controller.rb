class ProductsController < ApplicationController
  before_action :find_product, only: :show

  def index
    @categories = Category.active_status
    @brands = Brand.active_status
    @products = Product.by_name(params[:keyword])
                       .by_brand(params[:brand])
                       .includes(:images)
                       .page(params[:page])
                       .per Settings.per_page
  end

  def show
    @related_products = Product.by_category(@product.category_id)
                               .includes(:images)
                               .limit Settings.per_page_four
  end

  private

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".unknown_product"
    redirect_to root_path
  end
end
