class StaticPagesController < ApplicationController
  before_action :load_products, only: :home

  def home
    @lastest_products = Product.active_status.includes(:images)
    @products_of_categories = Product.by_status_images(Settings.active)
                                     .includes :category, :images
  end

  def help; end

  private

  def load_products
    @products = {
      mobile: Product.by_category(@categories[0].id)
                     .active_status
                     .includes(:category, :images),
      tablet: Product.by_category(@categories[1].id)
                     .active_status
                     .includes(:category, :images),
      laptop: Product.by_category(@categories[2].id)
                     .active_status
                     .includes(:category, :images)
    }
  end
end
