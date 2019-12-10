class EventMailer < ApplicationMailer
  default from: 'no-reply@citoyens-producteurs.fr'

  def new_event_user(event)
   #on récupère l'instance event pour ensuite pouvoir la passer à la view en @event
    @event = event
    @creator_id = @event.creator_id
    @user = User.find_by(id: @creator_id) #@user = @event.creator
    @user_email = @user.email
    @user_first_name = @user.first_name
    @user_last_name = @user.last_name
   #on définit une variable @url qu'on utilisera dans la view d’e-mail
   @url  = 'www.citoyens-producteurs.fr' 
   # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
   mail(to: @user.email, subject: 'Tu as crée un nouvel événement !') 
  end

  def event_edit_user(event)
     @event = event
     @creator_id = event.creator_id
     @creator = User.find_by(id: @creator_id) 
     @creator_email = @creator.email
     @creator_first_name = @creator.first_name
     @creator_last_name = @creator.last_name
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'www.citoyens-producteurs.fr' 
    @appointments = Appointment.where(event_id: @event.id)
    @appointments.each do |appointment|
    mail(to: appointment.user.email, subject: 'Un évènement a été modifié !') 
    end

   end

end
  