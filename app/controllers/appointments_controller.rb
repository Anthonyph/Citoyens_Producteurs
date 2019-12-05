class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:index, :new, :edit, :create, :update, :destroy]

  
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
    @appointment = @event.appointments.new(start_date: params[:start_date], duration: params[:duration], user_id: current_user.id, event_id: [:event_id], status: 'to_validate', points: 0)
    # @appointment = @event.appointments.new(appointment_params.merge(status: 'to_validate'))
    if @appointment.save!
      redirect_to @event, success: 'Appointment created'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end


  def update
    if @appointment.update(appointment_params)
      redirect_to event_path(@event), notice: 'Appointment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    flash[:destroyed] = 'Appointment was deleted'
    redirect_back(fallback_location: @event)
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_date, :duration, :user_id, :event_id)
  end
end
