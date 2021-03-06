class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :is_blank_phone_number?,  only: [:new, :create,:edit,:update] 
  

  
  # GET /events/:event_id/appointments
  def index
    @appointments = @event.appointments
  end

  # GET /events/:event_id/appointments/new
  def new
    @appointment = @event.appointments.new
  end

  # POST /events/:event_id/appointments
  def create
    @appointment = @event.appointments.new(appointment_params.merge(status: 'to_validate'))    
    
    if @appointment.start_date == nil
      flash.now[:danger] = "Attention! tu n'as pas choisi ta date de participation !"
        render :new
    else
      end_time = (@appointment.start_date) + @appointment.duration.minutes
      if @appointment.start_date < @event.start_date || @appointment.start_date >@event.end_date
        flash.now[:danger] = "Attention! tu dois choisir une date dans le créneau proposé!"
        render :new
      elsif end_time > @event.end_date
        flash.now[:danger] = "Attention! ta durée de participation ne dois pas depasser le créneau proposé!"
        render :new
      else
        if @appointment.save
          flash[:success] = "Ta participation à bien été enregistrée ! Un email vient de t'être envoyé avec plus d'infomations sur l'événement !"
          redirect_to user_path(current_user.id)
        else
          flash.now[:danger] = 'Something went wrong, please check your input'
          render :new
        end
      end
    end
  end

  def show
  end

  def edit
  end


  def update
    end_time = (@appointment.start_date) + @appointment.duration.minutes
    if @appointment.start_date < @event.start_date || @appointment.start_date > @event.end_date
      flash.now[:danger] = "Attention! tu dois choisir une date dans le créneau proposé!"
      render :edit
    elsif end_time > @event.end_date
      flash.now[:danger] = "Attention! ta durée de participation ne dois pas depasser le créneau proposé!"
      render :edit
    else
      if @appointment.update(appointment_params)
        redirect_to event_path(@event), notice: 'Appointment was successfully updated.'
      else
        flash.now[:danger] = 'Something went wrong, please check your input'
        render :edit
      end
    end
  end

  def destroy
    if params[:destroy_event] == true 
      @appointment.destroy
      flash[:destroyed] = 'Appointment was deleted'
      redirect_back(fallback_location: @event)
    else
      AppointmentMailer.destroy_appointment_user(@appointment).deliver_now
      AppointmentMailer.destroy_appointment_creator(@appointment).deliver_now
      @appointment.destroy
      flash[:destroyed] = 'Ta participation à été supprimée !'
      redirect_to user_path(current_user.id)
    end

  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

     

  def is_blank_phone_number?  
    if current_user.phone_number.blank?
      flash[:danger] = "Attention! pour rejoindre un événement, tu dois d'abord renseigner ton numéro de téléphone!(seul le créateur et les autres participants y auront accès)"
      redirect_to edit_user_registration_path
    end  
  end

  

  def appointment_params
    params.require(:appointment).permit(:start_date, :duration, :points, :user_id, :event_id)
  end
end
