class Admin::EventTypesController < ApplicationController
  
  before_action :check_if_admin
  before_action :set_type,only: [:show,:edit,:update,:destroy]
  
  def index
  
    @event_types = EventType.all
  end
  
  def show
  end
      
  
  def new
    @newtype = EventType.new
  end
  
  def create
  
    @newtype = EventType.new(name: product_params[:name])
    if @newtype.save
      flash[:success] = 'Event type successfully created'
      redirect_to '/admin/event_types'
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render new_admin_event_type_path
    end
  
  end
  
  def edit
     
  end
  
  def update
      
    
    if @type.update(product_params)
      flash[:success] = 'Product successfully updated'
      redirect_to '/admin/event_types'
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render :edit
    end
        
  end

  def destroy
    
    @type.destroy 
    flash[:danger] = "Le type d'évenement #{@type.name} à bien été supprimmé"
    redirect_to '/admin/event_types'
  end
  
  private  

  def set_type
    @type = EventType.find(params[:id])
  end

  
  def product_params
  
    params.require(:event_type).permit(:name)
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
