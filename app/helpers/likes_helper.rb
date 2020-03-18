module LikesHelper
  def already_liked?
    Like.where(user_id: current_user.id, blog:
    params[:blog]).exists?
  end
end
