class BlogController < ApplicationController

  def index
    @blogs = Blog.all
    @stores = Store.all
  end

  def create
    @blog = Blog.new(blog_params)
  end

  private

  def blog_params
    params.require(:comment).permit(:title, :content, :user_id)
  end

end
