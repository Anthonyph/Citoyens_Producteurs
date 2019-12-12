class Admin::StoreProductsController < ApplicationController
  before_action :check_if_admin  
  before_action :set_stock, only: [:show,:edit, :update, :destroy]

  def index
    @stocks = StoreProduct.all
  end

  def new
    @stock = StoreProduct.new
  end

  def create
    @product = Product.find(stock_params[:product])
    @unit = Unit.find(stock_params[:unit])
    @store = Store.find(stock_params[:store])
    @stock = StoreProduct.create(product: @product, unit: @unit, store: @store, quantity: stock_params[:quantity])
    redirect_to admin_store_path(stock_params[:store])
    
  end

  def edit
    
  end

  def update
    @unit = Unit.find(stock_params[:unit])
    @stock.update(unit: @unit,quantity: stock_params[:quantity])
    @store = Store.find(@stock.store.id)
    redirect_to admin_store_path(@store)
      
  end

  

  private  

  def set_stock
    @stock= StoreProduct.find(params[:id])
  end

  def stock_params
    params.require(:store_product).permit(:product,:unit,:store,:quantity)
  end

  def check_if_admin
    if current_user == nil
      flash[:danger] = "Vous n'avez pas acces a cette page"
      redirect_to '/'
    elsif current_user.is_admin == false
      flash[:danger] = "Vous n'avez pas acces a cette page"
      redirect_to '/'    
    end
  end

end
