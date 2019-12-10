class EventsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :destroy]

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

  
  def create
    @address = Address.create(place: event_params[:place], zip_code: event_params[:zip_code], city: event_params[:city], sector: event_params[:sector])
    @type = EventType.find(event_params[:type])
    @creator = User.find(current_user.id)
    @event = Event.new(event_type: @type, title: event_params[:title], description: event_params[:description], start_date: event_params[:start_date], end_date: event_params[:end_date], address: @address, creator: @creator)
    if @event.save
      flash[:success] = 'Event successfully created'
      redirect_to @event
    else
      flash.now[:danger] = 'Something went wrong, please check your input'
      render new_event_path
    end
  end
  
  def update
    @address1 = Event.find(params[:id]).address
    @address = Address.find(@address1.id).update(place: event_params[:place], zip_code: event_params[:zip_code], city: event_params[:city], sector: event_params[:sector])
    @type = EventType.find(event_params[:type])
    @creator = User.find(current_user.id)
    @event = Event.find(params[:id])
    @event.update(event_type: @type, title: event_params[:title], description: event_params[:description], start_date: event_params[:start_date], end_date: event_params[:end_date], address: @address_id, creator: @creator)
    #if @event.update(event_params)
    redirect_to @event, notice: 'Event was successfully updated.'
    #else
    #render :edit
    #end
  end

  def destroy
    @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:type, :title, :description, :start_date, :end_date, :place, :zip_code, :city, :sector, :creator, :creator_feedback)
  end
end
