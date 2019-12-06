class ProductController < ApplicationController

  def index
    @products = Product.all
    @productevents = ProductEvent.all
  end

  def show
    @product = Product.find(params[:id])
    @productevents = ProductEvent.all
    @storeproducts = StoreProduct.all
  end

  def new 
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to '/product ', notice: 'Product was successfully destroyed.'
  end

  def create

  end

  def update
  end

  def edit
  end



end
