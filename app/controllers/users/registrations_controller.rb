# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    @store = Store.find(user_params[:store])
    @address= @user.address
    
    if (@user.update(email: user_params[:email], first_name: user_params[:first_name], last_name:  user_params[:last_name], phone_number: user_params[:phone_number], store:@store)) && (@address.update(place: user_params[:place], zip_code: user_params[:zip_code], city:  user_params[:city], sector: user_params[:sector]))
            
      redirect_to user_path(current_user) # si ça marche, il redirige vers la page d'index du site
    else
      render :edit  # sinon, il render la view new (qui est celle sur laquelle on est déjà)
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:phone_number,:is_admin,:place,:zip_code,:city,:sector,:store,:password,:password_confirmation,:current_password)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :phone_number, :current_password, :password, :password_confirmation, :place, :zip_code, :city, :sector])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
