class OrdersController < ApplicationController
  include SessionsHelper

  before_action :get_cart, only: [:new, :create]

  def index; end

  def new
    unless current_user
      flash[:info] = t ".login_to_continue"
      redirect_to login_path
    end
    @order = Order.new
    @order.order_items.build
  end

  # rubocop:disable Metrics/AbcSize

  def create
    checked = true
    session[:cart]&.each do |item|
      amount = Product.find_by(id: item["product_id"].to_i).amount
      checked = false if amount < item["quantity"]
    end
    if checked
      @order = Order.new order_params
      if @order.save
        session[:cart].each do |item|
          product = Product.find_by(id: item["product_id"].to_i)
          product.update amount: product.amount - item["quantity"]
        end
        flash[:info] = t ".order_created_success"
        session.delete :cart
        redirect_to root_path
      else
        flash[:danger] = t ".order_create_failed"
        render :new
      end
    else
      flash[:danger] = t ".order_create_failed"
      render :new
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update; end

  private

  # rubocop:disable Metrics/AbcSize

  def get_cart
    @product_ids = []
    if session[:cart]
      session[:cart].sort_by!{|k| k["product_id"].to_i}
      session[:cart].each do |item|
        @product_ids.push(item["product_id"])
      end
    end
    @carts = Product.filter_by_ids(@product_ids)
    @total = session[:cart].map do |item|
      item["quantity"] * Product.find_by(id: item["product_id"].to_i).price
    end.sum
  end
  # rubocop:enable Metrics/AbcSize

  def order_params
    params.require(:order).permit Order::PERMIT_CREATE_ATTRIBUTES
  end
end
