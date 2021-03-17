# frozen_string_literal: true

class SamlController < ApplicationController
  skip_before_action :check_signed_in
  skip_forgery_protection only: :consume

  def consume
    saml_response = Base64.decode64(params[:SAMLResponse])

    response = OneLogin::RubySaml::Response.new(saml_response, settings: saml_settings,
                                                               skip_subject_confirmation: true)

    # We validate the SAML Response and check if the user already exists in the system
    if response.is_valid?
      # authorize_success, log the user
      # session[:userid] = response.nameid
      # session[:attributes] = response.attributes
      p 'success'
      user = User.find_by(email: response.nameid)
      sign_in(user: user)

      p signed_in?
      redirect_to root_path
    else
      p 'failed'
      p response.errors
      # This method shows an error message
      # List of errors is available in response.errors array
    end
  end

  def metadata
    settings = saml_settings
    meta = OneLogin::RubySaml::Metadata.new
    render xml: meta.generate(settings), content_type: 'application/samlmetadata+xml'
  end

  private

  def saml_settings
    account = Account.find(params[:id])
    saml_setting = account.saml_setting
    settings = OneLogin::RubySaml::Settings.new

    settings.idp_entity_id                  = saml_setting.entity_id
    settings.idp_sso_service_url            = saml_setting.sso_url
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
