RSpec.shared_examples "create example product" do
  before do
    FactoryBot.create(
      :product,
      name: "Điện thoại",
      amount: 100,
      price: 100000,
      description: "Máy mới nhất",
      status: "active",
      brand_id: brand.id,
      category_id: category.id
    )
    FactoryBot.create(
      :product,
      name: "Samsung Galaxy X",
      amount: 100,
      price: 100000,
      description: "Máy mới nhất",
      status: "active",
      brand_id: brand.id,
      category_id: category.id
    )
    FactoryBot.create(
      :product,
      name: "Iphone X",
      amount: 100,
      price: 10000000,
      description: "Máy mới nhất",
      status: "active",
      brand_id: brand.id,
      category_id: category.id
    )
    FactoryBot.create(
      :product,
      name: "Điện thoại",
      amount: 100,
      price: 10000000,
      description: "Máy mới nhất",
      status: "unactive",
      brand_id: brand.id,
      category_id: category.id
    )
  end
end
