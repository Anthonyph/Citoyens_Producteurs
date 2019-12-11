class Admin::StoreProductsController < ApplicationController
  before_action :check_if_admin
  before_action :set_store
  before_action :set_stock,only: [:show,:edit,:update,:destroy]

  def index
    @stocks= @store.store_products

    
  end

  def show
    
  end

  def new
    @stock = StoreProduct.new
  end

  def create
    @product = Product.find(stock_params[:product])
    @unit = Unit.find(stock_params[:unit])
    @store = Store.find(stock_params[:store])
    @stock = StoreProduct.create(product: @product, unit: @unit, store: @store, quantity: stock_params[:quantity])
    redirect_to '/admin/store_products/'
    if @stock.save
      flash[:success] = 'store product successfully created'
      
      
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render new_store_product_path
    end

  end

  def edit
    
  end

  def update
    
    @product = Product.find(params[:id]) 
    if @product.update(product_params)
      flash[:success] = 'Product successfully updated'
      redirect_to '/admin/products'
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render :edit
    end
      
  end

  def destroy
    @stock.destroy
    flash[:success] = "L'évenement #{@stock.product.name} à bien été supprimmé"
    redirect_to 'admin_store_path(store_id)'
  end

  

  private  

  def set_store
    @store= Store.find(1)
    
  end

  def set_stock
    #@store= Store.find(params[:store_id])
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
