class Admin::StoreProductsController < ApplicationController
  before_action :check_if_admin

  def index

    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create

    @product = Product.new(name: product_params[:name])
    if @product.save!
      flash[:success] = 'Product successfully created'
      redirect_to '/admin/products'
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render new_admin_product_path
    end

  end

  def edit
    @product = Product.find(params[:id])
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

  

  private  

  def product_params

    params.require(:product).permit(:name)
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
