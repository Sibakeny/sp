class SessionsController < ApplicationController

  def new
    user = User.find(params[:id])

    request = OneLogin::RubySaml::Authrequest.new
    saml_settings.name_identifier_value_requested = "admin@mcloud.local"
    saml_settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    p request.create(saml_settings).strip

    redirect_to(request.create(saml_settings).strip)
  end

  def create
  end

  private

  def saml_settings
    user = User.find(params[:id])
    sp_setting = user.sp_setting
    settings = OneLogin::RubySaml::Settings.new

    settings.issuer = "http://#{request.host}:3001/saml/metadata?id=1"

    settings.assertion_consumer_service_url = "http://#{request.host}:3001/saml/sso"
    settings.sp_entity_id                   = "http://#{request.host}:3001/saml/metadata?id=1"
    settings.idp_entity_id                  = "http://localhost:3000/saml/metadata/xFEAU6j6wbEQ0TH1RcKTeA"
    settings.idp_sso_service_url            = sp_setting.sso_url.strip
    settings.idp_slo_service_url            = sp_setting.slo_url
    settings.idp_cert                       = sp_setting.x509_certificate
    # settings.idp_cert_fingerprint           = sp_setting.certificate_fingerprint
    # settings.idp_cert_fingerprint_algorithm = sp_setting.certificate_fingerprint_algorithm
    settings.name_identifier_format         = sp_setting.name_id_format

    # Optional for most SAML IdPs
    settings.authn_context = sp_setting.authn_context
    # # or as an array
    # settings.authn_context = [
    #   "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
    #   "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
    # ]

    # Optional bindings (defaults to Redirect for logout POST for acs)
    settings.single_logout_service_binding      = sp_setting.slo_http_binding
    settings.assertion_consumer_service_binding = sp_setting.sso_http_binding

    settings
  end
end
