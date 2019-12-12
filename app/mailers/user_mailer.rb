class UserMailer < ApplicationMailer
  default from: 'no-reply@citoyens-producteurs.fr'

   
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'www.citoyens-producteurs.fr' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez Citoyens Producteurs !') 
  end

  def user_has_payed(user) 
    ##########
    @user = user

    @url = 'www.citoyens-producteurs.fr'

    mail(to: @user.email, subject: 'Merci d\'avoir payé ta cotisation pour  Citoyens Producteurs !') 
  end

end
