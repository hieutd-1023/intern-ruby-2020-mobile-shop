class OrdersController < ApplicationController
  before_action :get_cart, only: %i(new create)

  def index; end

  def new
    unless current_user
      flash[:info] = t ".login_to_continue"
      redirect_to login_path
    end
    @order = Order.new
    @order.order_items.build
  end

  def create
    @order = Order.new order_params
    if @order.save
      flash[:success] = t ".order_created_success"
      session.delete :cart
      redirect_to root_path
    else
      flash[:danger] = t ".order_create_failed"
      render :new
    end
  end

  def update; end

  private

  # rubocop:disable Metrics/AbcSize

  def get_cart
    @product_ids = []
    if session[:cart]
      session[:cart].sort_by!{|k| k["product_id"].to_i}
      session[:cart].each do |item|
        @product_ids.push item["product_id"]
      end
    end
    @carts = Product.filter_by_ids @product_ids
    @total = session[:cart].map do |item|
      item["quantity"] * Product.find_by(id: item["product_id"].to_i).price
    end.sum
  end
  # rubocop:enable Metrics/AbcSize

  def order_params
    params.require(:order).permit Order::PERMIT_CREATE_ATTRIBUTES
  end
end
