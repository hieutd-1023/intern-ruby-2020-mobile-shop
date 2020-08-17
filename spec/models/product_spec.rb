require "rails_helper"

RSpec.describe Product, type: :model do
  let!(:brand) { FactoryBot.create :brand }
  let!(:category) { FactoryBot.create :category }

  subject { FactoryBot.build :product, brand_id: brand.id, category_id: category.id }

  describe "Validation" do
    it { is_expected.to be_valid }
  end

  describe "Associations" do
    it { is_expected.to belong_to :brand }
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many(:images) }
  end

  describe "Enums" do
    it { is_expected.to define_enum_for(:status).with([:unactive, :active]) }
  end

  describe "Delegate" do
    it { is_expected.to delegate_method(:name).to(:category).with_prefix(true) }
  end

  describe "Nested attributes" do
    it { is_expected.to accept_nested_attributes_for(:images).allow_destroy(true) }
  end

  describe "Scopes" do
    include_examples "create example product"

    context "with brand filtered" do
      it "should return filtered products by brand" do
        expect(Product.by_brand(brand.id).size).to eq(Settings.products.filtered_by_brand)
      end
    end

    context "with name filtered" do
      it "should return filtered products by name" do
        expect(Product.by_name("Samsung").size).to eq(Settings.products.filtered_by_samsung)
        expect(Product.by_name("Iphone").size).to eq(Settings.products.filtered_by_iphone)
      end
    end

    context "with category filtered" do
      it "should return filtered products by category" do
        expect(Product.by_category(category.id).size).to eq(Settings.products.filtered_by_category)
      end
    end

    context "with status filtered" do
      it "should return filtered products by status" do
        expect(Product.by_status("active").size).to eq(Settings.products.filtered_by_status)
      end
    end

    context "with by_from_price filtered" do
      it "should return filtered products by by_from_price" do
        expect(Product.by_from_price(1000000).size).to eq(Settings.products.filtered_by_from_price)
      end
    end

    context "with by_to_price filtered" do
      it "should return filtered products by by_to_price" do
        expect(Product.by_from_price(1000000).size).to eq(Settings.products.filtered_by_to_price)
      end
    end
  end
end
