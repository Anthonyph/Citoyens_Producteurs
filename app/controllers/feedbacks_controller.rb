class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:index, :new, :edit, :create, :update, :destroy]

  def new
    @feedback = @event.feedbacks.new
  end

  def create
    if current_user == @event.creator
      @feedback = @event.feedbacks.new(feedback_params.merge(feedbackable: @event))
    else
      @appointment = @event.appointments.find { |appointment| appointment.user_id == current_user.id}
      @feedback = @appointment.feedbacks.new(feedback_params.merge(feedbackable: @appointment))
    end
    if @feedback.save
      redirect_to @event, success: 'Feedback created'
    else
      render :new
    end
  end

  private

  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
  

  def feedback_params
    params.require(:feedback).permit(:content, :rating)
  end

end
