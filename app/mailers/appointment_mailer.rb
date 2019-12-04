class AppointmentMailer < ApplicationMailer
  default from: 'no-reply@citoyens-producteurs.fr'

  def new_appointment_user(appointment)
    @apt = appointment
    @title = @apt.event.title
    @apt_duration = @apt.duration
    @apt_start_date = @apt.start_date
    @user = @apt.user
    @points = @apt.points
    @user_email = @apt.user.email
    @user_first_name = @apt.user.first_name
    @user_last_name = @apt.user.last_name
    @creator = @apt.event.creator
    @creator_email = @creator.email
    @creator_phonenumber = @creator.phone_number
    @creator_first_name = @creator.first_name
    @creator_last_name = @creator.last_name

    @url  = 'www.citoyens-producteurs.fr' 
    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user_email, subject: 'Tu as rejoint un événement !') 
  end

  def new_appointment_creator(appointment)

    @apt = appointment
    @title = @apt.event.title
    @apt_duration = @apt.duration
    @apt_start_date = @apt.start_date
    @user = @apt.user
    @user_email = @apt.user.email
    @user_phone_number = @user.phone_number
    @user_first_name = @apt.user.first_name
    @user_last_name = @apt.user.last_name
    @points = @apt.points
    @creator = @apt.event.creator
    @creator_email = @creator.email
    @creator_phonenumber = @creator.phone_number
    @creator_first_name = @creator.first_name
    @creator_last_name = @creator.last_name
    
    @url  = 'www.citoyens-producteurs.fr' 
    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @creator_email, subject: 'Un nouveau citoyen s\'est inscrit à ton événement!') 
  end

end
