# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname, :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :birthday
    ])
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
