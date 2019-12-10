class CommentMailer < ApplicationMailer
  default from: 'no-reply@citoyens-producteurs.fr'
  
  def new_comment(comment)
    @comment = comment
    @text = @comment.text
    @comment_creator_first_name = @comment.user.first_name
    @comment_creator_last_name = @comment.user.last_name
    @comment_creator_email = @comment.user.email
    @creator_email = @comment.event.creator.email
    @creator_first_name = @comment.event.creator.first_name
    @creator_last_name = @comment.event.creator.last_name

    @url = 'www.citoyens-producteurs.fr' 
    mail(to: @creator_email, subject: 'Tu as reçu un commentaire sur ton évènement !') 
  end

end
