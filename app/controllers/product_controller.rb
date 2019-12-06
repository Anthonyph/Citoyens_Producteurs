class ProductController < ApplicationController

  def index
    @products = Product.all
    @productevents = ProductEvent.all
  end

  def show
    @product = Product.find(params[:id])
    @productevents = ProductEvent.all
  end

  def new 
  end

  def destroy
    @product.destroy
    redirect_to events_url, notice: 'Product was successfully destroyed.'
  end

  def create

  end

  def update
  end

  def edit
  end



end
