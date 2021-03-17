# frozen_string_literal: true

class Account < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one :saml_setting

  def saml_attributes(user: nil)

    settings = OneLogin::RubySaml::Settings.new

    settings.name_identifier_value_requested = user.email if user.present?

    settings.issuer = saml_metadata_url(id)

    settings.assertion_consumer_service_url = saml_sso_url(id)
    settings.sp_entity_id                   = saml_metadata_url(id)
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
