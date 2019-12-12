class Admin::EventsController < ApplicationController
  require 'time'
  before_action :set_event, only: [:show, :edit, :update, :destroy]
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

  def update
    if params[:is_passed] == nil
      @address = @event.address
      @address.update(place: event_params[:place], zip_code: event_params[:zip_code], city: event_params[:city], sector: event_params[:sector])
      @type = EventType.find(event_params[:type])
      @creator = @event.creator
      @event.update!(event_type: @type, title: event_params[:title], description: event_params[:description], start_date: event_params[:start_date], end_date: event_params[:end_date], address: @address, creator: @creator)
      flash[:success] = 'Event successfully updated'
      @appointments = Appointment.where(event_id: @event.id)
      ############ MAILER ##################
      @appointments.each do |appointment|
      EventMailer.event_edit_user(appointment).deliver_now
      end
      ############ Redirect ##################
      redirect_to '/admin/events', notice: 'Event was successfully updated.'
    elsif params[:is_passed] == true
      @event.update(is_passed: true)
      @appointments = Appointment.where(event_id: @event.id)
      ############ MAILER ##################
      @appointments.each do |appointment|
      EventMailer.ask_feedback(appointment).deliver_now
      ############ MAILER ##################
      end
      
    end
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
    @current_events= []
    @events = Event.all
    @events.each do |event|
    
      if event.end_date.strftime("%-d %B %Y à %Hh %Mm %Ss") < DateTime.now.strftime("%-d %B %Y à %Hh %Mm %Ss")
        @event_past<< event 
      elsif event.end_date.strftime("%-d %B %Y à %Hh %Mm %Ss") > DateTime.now.strftime("%-d %B %Y à %Hh %Mm %Ss") && event.start_date.strftime("%-d %B %Y à %Hh %Mm %Ss") < DateTime.now.strftime("%-d %B %Y à %Hh %Mm %Ss")
        @current_events<< event
      else
        @future_events<< event
      end
    end
  end
      

end


