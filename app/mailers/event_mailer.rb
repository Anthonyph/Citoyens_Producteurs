class EventMailer < ApplicationMailer
  default from: 'no-reply@citoyens-producteurs.fr'

  def new_event_user(event)
   #on récupère l'instance event pour ensuite pouvoir la passer à la view en @event
    @event = event
    @creator_id = event.creator_id
    @user = User.find_by(id: @creator_id) #@user = @event.creator
    @user_email = @user.email
    @user_first_name = @user.first_name
    @user_last_name = @user.last_name
   #on définit une variable @url qu'on utilisera dans la view d’e-mail
   @url  = 'www.citoyens-producteurs.fr' 
   # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
   mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

end
