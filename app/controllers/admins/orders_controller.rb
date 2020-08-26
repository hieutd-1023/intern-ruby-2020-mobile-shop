class Admins::OrdersController < AdminsController
  before_action :find_order, only: %i(edit update)
  before_action :find_order_items, only: %i(edit)

  def index
    @search = Order.ransack(params[:q])
    @orders = @search.result.includes(:order_items)
                     .page(params[:page])
                     .per(Settings.per_page)
  end

  def new
    @order = Order.new
    @order.order_items.build
    @products = Product.active_status
  end

  def create
    @order = Order.new order_params
    if @order.save
      flash[:success] = t ".order_created_success"
      redirect_to admins_orders_path
    else
      flash[:danger] = t ".order_create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @order.update order_params
      flash[:success] = t ".order_updated"
      redirect_to edit_admins_order_path(@order)
    else
      flash[:danger] = t ".order_update_fail"
      render :edit
    end
  end

  private

  def find_order
    @order = Order.find_by id: params[:id]
    return if @order.present?

    flash[:danger] = t ".unknown_order"
    redirect_to root_path
  end

  def find_order_items
    @order_items = @order.order_items.includes(:product)
  end

  def order_params
    params.require(:order).permit Order::PERMIT_CREATE_ATTRIBUTES
  end
end
