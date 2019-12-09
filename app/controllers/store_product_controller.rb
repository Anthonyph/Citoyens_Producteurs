class StoreProductController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  @store_products = StoreProduct.all
  end

end
