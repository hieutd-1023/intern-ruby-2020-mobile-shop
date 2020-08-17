require "rails_helper"
require "spec_helper"

RSpec.describe Admins::ProductsController, type: :controller do
  let!(:category) { FactoryBot.create :category }
  let!(:brand) { FactoryBot.create :brand }
  let!(:current_user) { FactoryBot.create :user, role: Settings.admin }
  let!(:params) { FactoryBot.attributes_for :product, brand_id: brand.id, category_id: category.id }
  let!(:product) { FactoryBot.create :product, brand_id: brand.id, category_id: category.id }

  context "when user logged in" do
    before { log_in current_user }

    describe "GET #new" do
      before { get :new }

      it "should render view new" do
        expect(response).to render_template :new
      end

      it "should assign @product" do
        expect(assigns(:product)).to be_a_new(Product)
      end
    end

    describe "POST #create" do
      context "when valid param" do
        before { post :create, params: {product: params} }

        it "should redirect to root url" do
          expect(response).to redirect_to admins_products_path
        end

        it "should return success message" do
          expect(flash[:success]).to eq I18n.t(".admins.products.create.product_created_success")
        end
      end

      context "when invalid param" do
        before { post :create, params: {product: {name: ""}} }

        it "should render view new" do
          expect(response).to render_template :new
        end

        it "should return error message" do
          expect(flash[:danger]).to eq I18n.t(".admins.products.create.product_create_failed")
        end
      end
    end

    context "when product exists" do
      include_examples "create example product"
      describe "GET #edit" do
        before { get :edit, params: {id: product.id} }
        it "should render view edit" do
          expect(response).to render_template :edit
        end
      end

      describe "PATCH #update" do
        context "when valid param" do
          before { patch :update, params: {id: product.id, product: params} }

          it "should update and redirect to product" do
            expect(response).to redirect_to admins_product_path
          end

          it "should return success message" do
            expect(flash[:success]).to eq I18n.t(".admins.products.update.product_updated")
          end
        end

        context "when invalid param" do
          before { patch :update, params: {id: product.id, product: {name: ""}} }

          it "should render edit" do
            expect(response).to render_template :edit
          end

          it "should return error message" do
            expect(flash[:danger]).to eq I18n.t(".admins.products.update.product_update_fail")
          end
        end
      end

      describe "DELETE #destroy" do
        context "when valid param" do
          before { delete :destroy, params: {id: product.id} }

          it "should return success message" do
            expect(flash[:success]).to eq I18n.t(".admins.products.destroy.product_deleted")
          end

          it "should redirect to root url" do
            expect(response).to redirect_to admins_products_path
          end
        end

        context "when invalid param" do
          before { delete :destroy, params: {id: 9999} }

          it "should return error message" do
            expect(flash[:danger]).to eq I18n.t(".admins.products.destroy.unknown_product")
          end
        end
      end
    end

    context "when product doesn't exist" do
      before { get :edit, params: {id: 9999} }

      it "should return error message" do
        expect(flash[:danger]).to eq I18n.t(".admins.products.edit.unknown_product")
      end

      it "should redirect request referer or root url" do
        expect(response).to redirect_to request.referer || root_url
      end
    end
  end
end
