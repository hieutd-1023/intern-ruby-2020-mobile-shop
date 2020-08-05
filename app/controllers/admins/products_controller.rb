class Admins::ProductsController < AdminsController
  before_action :find_product, only: %i(show edit update destroy)
  before_action :fetch_products, :join_products, :paginate_products,
                only: [:index]
  before_action :fetch_categories, :fetch_brands,
                only: %i(new create edit)

  def index
    @categories = Category.all
    @brands = Brand.all
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:info] = t ".product_created_success"
      redirect_to admins_products_path
    else
      flash[:danger] = t ".product_create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t ".product_updated"
      redirect_to [:admins, @product]
    else
      flash[:danger] = t ".product_update_fail"
      render :edit
    end
  end

  def show; end

  def destroy
    if @product.destroy
      flash[:success] = t ".product_deleted"
      redirect_to admins_products_path
    else
      flash[:danger] = t ".product_delete_fail"
      redirect_to root_path
    end
  end

  private

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".unknown_product"
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit Product::PERMIT_ATTRIBUTES
  end

  def fetch_categories
    @categories = Category.all
  end

  def fetch_brands
    @brands = Brand.all
  end

  def fetch_products
    @products = Product.by_name(params[:keyword])
                       .by_brand(params[:brand_id])
                       .by_category(params[:category_id])
                       .by_from_price(params[:from_price])
                       .by_to_price(params[:to_price])
  end

  def join_products
    @products = @products.includes(:images)
                         .includes(:brand)
                         .includes(:category)
  end

  def build_images
    @product.images.build
  end

  def paginate_products
    @products = @products.page(params[:page])
                         .per Settings.per_page
  end
end
