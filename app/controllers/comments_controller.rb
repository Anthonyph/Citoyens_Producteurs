class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:create, :edit, :update]

  def index
    @comments = Comment.all
  end

  def show
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @event = Event.find(comment_params[:event_id])
    if @comment.save
      flash[:success] = 'Comment was succesfully created'
    else
      flash[:danger] = 'Comment could not be created - check your input'
    end
    redirect_back(fallback_location: @event)
  end

  def update
    if @comment.update(comment_params)
      redirect_to event_path(@event), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:destroyed] = 'Comment was deleted'
    redirect_back(fallback_location: @event)
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_event
      @event = Event.find(comment_params[:event_id])
    end

    def comment_params
      params.require(:comment).permit(:text, :user_id, :event_id)
    end
end
