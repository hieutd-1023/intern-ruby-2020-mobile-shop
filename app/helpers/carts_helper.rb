module CartsHelper
  def option_status_order
    Order.statuses.map do |value, _key|
      [I18n.t("admins.orders.form_search.#{value}"), value]
    end
  end

  def option_status_product
    Product.statuses.map do |value, key|
      [I18n.t("admins.products.form_search.#{value}"), key]
    end
  end

  def active_treeview_menu treeview_items, type = :class
    match_items = request.path.split("/")
    return unless match_items.include? treeview_items

    type
  end
end
