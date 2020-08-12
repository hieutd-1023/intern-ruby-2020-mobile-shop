class ProductsController < ApplicationController
  before_action :find_product, only: :show
  before_action :fetch_categories, :fetch_brands, :fetch_products,
                :join_products, :paginate_products, only: :index

  def index; end

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

  def fetch_categories
    @categories = Category.active_status
  end

  def fetch_brands
    @brands = Brand.active_status
  end

  def fetch_products
    @products = Product.by_name(params[:keyword])
                       .by_brand(params[:brand])
                       .by_category(params[:category_id])
                       .order_by_price(params[:order])
  end

  def join_products
    @products = @products.includes(:images)
  end

  def paginate_products
    @products = @products.page(params[:page])
                         .per Settings.per_page
  end
end
