class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit,:update, :destroy]

  def index
    @blogs = Blog.all
    @stores = Store.all
  end
  
  def new
    @blog = Blog.new
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Post créé avec succès."
      redirect_to blogs_url
    else
      flash[:danger] = "Le post n'a pas pu être créé, tous les champs doivent être renseignés"
      redirect_to new_blog_path
    end
  end

  def show
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path
  end


  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    blog_params = params.require(:blog).permit(:title, :content, :user_id)
  end

end
