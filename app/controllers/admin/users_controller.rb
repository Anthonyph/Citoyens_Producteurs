class Admin::UsersController < ApplicationController

  before_action :check_if_admin, user_detail


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
   
    @users = User.all
    
      
    user_params= params.require(:user).permit(:email,:description,:first_name,:is_admin)    
      if @user_detail.update(user_params) # essaie de sauvegarder en base @gossip
            
      redirect_to admin_user_path(@user_detail.id) # si ça marche, il redirige vers la page d'index du site
    else
      render :edit  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end
  def destroy
    
    @user_detail.destroy 
    flash[:danger] = "L'utilisateur #{@user_detail.email} à bien été supprimmé"
    redirect_to '/admin'
  end

  private

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
