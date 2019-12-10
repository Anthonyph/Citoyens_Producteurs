class Admin::UsersController < ApplicationController

  before_action :check_if_admin
  before_action :user_detail, only: [:show,:create,:update,:destroy,:edit]

  def index
    
    @users = User.all
    
  end

  def show
    
    @events = Event.all
    
  end
  

  def new
  end
  def create
  end
  def edit        
  end
  def update 
        
    @store = Store.find(user_params[:store])
    @address= @user_detail.address
    
    
    if (@user_detail.update(email: user_params[:email], first_name: user_params[:first_name], last_name:  user_params[:last_name], phone_number: user_params[:phone_number], is_admin: user_params[:is_admin], store:@store))&& (@address.update(place: user_params[:place], zip_code: user_params[:zip_code], city:  user_params[:city], sector: user_params[:sector]))
            
      redirect_to admin_user_path(@user_detail.id) # si ça marche, il redirige vers la page d'index du site
    else
      render :edit  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
      
  end

  def destroy
    
    @user_detail.destroy 
    flash[:danger] = "L'utilisateur #{@user_detail.email} à bien été supprimmé"
    redirect_to '/admin/users'
  end

  private

  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:phone_number,:is_admin,:place,:zip_code,:city,:sector,:store)
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

  def user_detail
    @user_detail = User.find(params[:id])
  end

end
