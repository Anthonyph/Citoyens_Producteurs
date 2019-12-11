class Admin::EventsController < ApplicationController

  before_action :set_event, only: [:show, :destroy]
  before_action :is_past, only: [ :index]

  def index
    @events = Event.all
    @stores = Store.all
  end

  def show
    @comment = Comment.new
  end
  
  def new
    @event = Event.new
  end

  def edit
  end

  
  
  
 
  def destroy
    @event.destroy
    flash[:success] = "L'évenement #{@event.title} à bien été supprimmé"
    redirect_to '/admin/events'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
  

  def event_params
    params.require(:event).permit(:type, :title, :description, :start_date, :end_date, :place, :zip_code, :city, :sector, :creator, :creator_feedback)
  end

  def is_past
    @event_past= []
    @future_events= []
    @events = Event.all
    @events.each do |event|
    
      if event.end_date < DateTime.now
        @event_past<< event 
      else
        @future_events<< event
      end
    end
  end
      

end


