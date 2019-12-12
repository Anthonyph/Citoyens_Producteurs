class Admin::UnitsController < ApplicationController
  before_action :check_if_admin
  before_action :set_unit,only: [:show,:edit,:update,:destroy]
  
  def index
  
    @units = Unit.all
  end
  
  def show
  end
      
  
  def new
    @newunit = Unit.new
  end
  
  def create
  
    @newunit = Unit.new(name: unit_params[:name])
    if @newunit.save!
      flash[:success] = 'Unit successfully created'
      redirect_to '/admin/units'
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render new_admin_unit_path
    end
  
  end
  
  def edit
     
  end
  
  def update
      
    
    if @unit.update(unit_params)
      flash[:success] = 'Unit successfully updated'
      redirect_to '/admin/units'
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render :edit
    end
        
  end

  def destroy
    
    @unit.destroy 
    flash[:danger] = "L'unité #{@unit.name} à bien été supprimmé"
    redirect_to '/admin/units'
  end
  
  private  

  def set_unit
    @unit = Unit.find(params[:id])
  end

  
  def unit_params
  
    params.require(:unit).permit(:name)
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
