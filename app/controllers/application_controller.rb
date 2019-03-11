class ApplicationController < ActionController::Base
  helper_method :set_gender

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: %i[about]
  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone gender profile_picture profile_picture_cache cpf birth_date doctor])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone profile_picture profile_picture_cache cpf birth_date doctor])
  end

  private

  def set_gender(doc)
    if doc.user.gender == "masculino"
      return "Dr."
    else
      return "Dra."
    end
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
