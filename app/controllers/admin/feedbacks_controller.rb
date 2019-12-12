class Admin::FeedbacksController < ApplicationController
  before_action :check_if_admin
  before_action :set_feedback, only: [:show, :destroy]

  def index

    @feedbacks = Feedback.all
  end

  def show
   
  end

  def destroy

    @feedback.destroy
    flash[:success] = "Le feedback #{@feedback.content} à bien été supprimmé"
    redirect_to '/admin/feedbacks'

  end

  private

  def set_feedback

    @feedback = Feedback.find(params[:id])

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
