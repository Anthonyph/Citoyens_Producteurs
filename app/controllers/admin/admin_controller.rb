class Admin::AdminController < ApplicationController

  before_action :check_if_admin 

  
  def index
    @users = User.all
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
end
