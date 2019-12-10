class StoresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.all
  end

  def show
    @events = @store.events

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
    @store.destroy
      redirect_to stores_url, notice: 'Le store a été supprimé avec succès'
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:id, :name, :place, :zip_code, :city, :sector)
  end
end
