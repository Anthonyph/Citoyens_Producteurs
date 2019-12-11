class Admin::StoresController < ApplicationController
  before_action :check_if_admin
  
  before_action :set_store, only: [:show, :edit, :update]

  def index
    @stores = Store.all
  end

  def show
    
    @stocks = @store.store_products

  end
  
  def new
    @store = Store.new
  end

  def edit
  end

  def create
    @address = Address.create(place: store_params[:place], zip_code: store_params[:zip_code], city: store_params[:city], sector: store_params[:sector])
    @store = Store.new(name: store_params[:name], address: @address)
    if @store.save
      flash[:success] = 'Store successfully created'
      redirect_to stores_path
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render new_store_path
    end
  end

  def update
    @address = @store.address
    if @address.update(place: store_params[:place], zip_code: store_params[:zip_code], city: store_params[:city], sector: store_params[:sector]) && @store.update(name: store_params[:name], address: @address)
      redirect_to @store, notice: 'Le store a été mis à jour avec succès'
    else
      render :edit
    end
  end

  def destroy
    @stock = StoreProduct.find(params[:id])
    @stock.destroy
    flash[:success] = "Le produit #{@stock.product.name} à bien été retiré du stock"
    redirect_to admin_store_path(params[:store_id])
  end

  

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:id, :name, :place, :zip_code, :city, :sector)
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
