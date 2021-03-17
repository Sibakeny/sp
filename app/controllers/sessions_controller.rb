# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :check_signed_in

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    @account = @user.account

    if @account.saml_setting.inactive?
      if @user.present?
        sign_in(user: @user)
        redirect_to users_path
      else
        render :new, alert: 'ログイン失敗'
      end
    else
      request = OneLogin::RubySaml::Authrequest.new
      redirect_to(request.create(saml_settings))
    end
  end

  def destroy
    sign_out
    redirect_to new_sessions_path
  end

  private

  def saml_settings
    saml_setting = @account.saml_setting
    settings = OneLogin::RubySaml::Settings.new

    settings.name_identifier_value_requested = @user.email

    settings.issuer = "http://#{request.host}:3001/saml/metadata?id=1"

    settings.assertion_consumer_service_url = "http://#{request.host}:3001/saml/sso?id=1"
    settings.sp_entity_id                   = "http://#{request.host}:3001/saml/metadata?id=1"
    settings.idp_entity_id                  = 'http://localhost:3000/saml/metadata/xFEAU6j6wbEQ0TH1RcKTeA'
    settings.idp_sso_service_url            = saml_setting.sso_url.strip
    settings.idp_slo_service_url            = saml_setting.slo_url
    settings.idp_cert                       = saml_setting.x509_certificate
    # settings.idp_cert_fingerprint           = saml_setting.certificate_fingerprint
    # settings.idp_cert_fingerprint_algorithm = saml_setting.certificate_fingerprint_algorithm
    settings.name_identifier_format         = saml_setting.name_id_format

    # Optional for most SAML IdPs
    settings.authn_context = saml_setting.authn_context
    # # or as an array
    # settings.authn_context = [
    #   "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
    #   "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
    # ]

    # Optional bindings (defaults to Redirect for logout POST for acs)
    settings.single_logout_service_binding      = saml_setting.slo_http_binding
    settings.assertion_consumer_service_binding = saml_setting.sso_http_binding

    settings
  end
end
