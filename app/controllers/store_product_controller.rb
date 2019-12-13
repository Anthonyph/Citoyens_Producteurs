class StoreProductController < ApplicationController
  before_action :authenticate_user!
  
  def index
  @store_products = StoreProduct.all
  end

end
