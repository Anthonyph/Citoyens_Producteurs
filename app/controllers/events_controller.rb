class EventsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit,:update, :destroy]
  before_action :is_default_address?, only: [:new, :create,:edit,:update]
  before_action :is_blank_phone_number?,  only: [:new, :create,:edit,:update] 
  
  before_action :is_creator?, only: [:edit]

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
    if params[:is_passed] == nil
      @address1 = Event.find(params[:id]).address
      @address = Address.find(@address1.id).update(place: event_params[:place], zip_code: event_params[:zip_code], city: event_params[:city], sector: event_params[:sector])
      @type = EventType.find(event_params[:type])
      @creator = User.find(current_user.id)
      @event.update(event_type: @type, title: event_params[:title], description: event_params[:description], start_date: event_params[:start_date], end_date: event_params[:end_date], address: @address1, creator: @creator)
      flash[:success] = 'Event successfully updated'
      @appointments = Appointment.where(event_id: @event.id)
      ############ MAILER ##################
      @appointments.each do |appointment|
      EventMailer.event_edit_user(appointment).deliver_now
      end
      ############ MAILER ##################
      if @creator.is_admin == true
        redirect_to '/admin/events'
      else
      redirect_to @event, notice: 'Event was successfully updated.'
      end
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
    @appointments = Appointment.where(event_id: @event.id)
    ############ MAILER ##################
    @appointments.each do |appointment|
    EventMailer.event_destroy_user(appointment).deliver_now
    end
    ############ MAILER ##################
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

  def is_default_address?
    if current_user.address.place == "default" || current_user.address.zip_code == "11111"|| current_user.address.city == "default" || current_user.address.sector == "default"
      flash[:danger] = "Attention! pour créer un événement, tu dois d'abord mettre à jour ton adresse! (seul ton quartier sera visible par les autres utilisateurs)"
      redirect_to edit_user_registration_path

    end
  end

  def is_blank_phone_number?  
    if current_user.phone_number.blank?
      flash[:danger] = "Attention! pour créer un événement, tu dois d'abord renseigner ton numéro de téléphone!(seul le créateur et les autres participants y auront accès)"
      redirect_to edit_user_registration_path
    end
  end  
      

  def is_creator?
    if current_user == @event.creator
    
    else
    redirect_to event_path
    end
  end

end
