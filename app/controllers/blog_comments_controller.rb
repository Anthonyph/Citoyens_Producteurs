class BlogCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_blog, only: [:create, :edit, :update]

  def index
    @comments = BlogComment.all
  end

  def show
  end

  def edit
  end

  def create
    @blog_comment = BlogComment.new(comment_params)
    @blog = Blog.find(comment_params[:blog_id])
    if @blog_comment.save
      flash[:success] = 'Le commentaire a été créé avec succès'
      respond_to do |format|
        format.html { redirect_back(fallback_location: @blog) }
        format.js { }
      end
    else
      flash[:danger] = 'Impossible de créer un commentaire - vérifiez votre saisie'
    end
  end

  def update
    if @blog_comment.update(comment_params)
      redirect_to blog_path(@blog), notice: 'Le commentaire a été mis à jour avec succès'
    else
      render :edit
    end
  end

  def destroy
    @blog_comment.destroy
    flash[:destroyed] = 'Comment was deleted'
    respond_to do |format|
      format.html { redirect_back(fallback_location: @blog) }
      format.js { }
    end
  end

  private

    def set_comment
      @blog_comment = BlogComment.find(params[:id])
    end

    def set_blog
      @blog = Blog.find(comment_params[:blog_id])
    end

    def comment_params
      params.require(:blog_comment).permit(:text, :user_id, :blog_id)
    end
end
