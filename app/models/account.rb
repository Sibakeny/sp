# frozen_string_literal: true

class Account < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one :saml_setting, dependent: :destroy

  after_create :create_saml_setting

  def saml_attributes(user: nil)
    settings = OneLogin::RubySaml::Settings.new

    settings.name_identifier_value_requested = user.email if user.present?

    settings.issuer = saml_metadata_url(id)

    settings.assertion_consumer_service_url = saml_consume_url(id)
    settings.sp_entity_id                   = saml_metadata_url(id)
    settings.idp_entity_id                  = saml_setting.entity_id
    settings.idp_sso_service_url            = saml_setting.sso_url
    settings.idp_slo_service_url            = saml_setting.slo_url
    settings.idp_cert                       = saml_setting.x509_certificate if saml_setting.x509_certificate.present?
    settings.idp_cert_fingerprint           = saml_setting.certificate_fingerprint if saml_setting.certificate_fingerprint.present?
    settings.idp_cert_fingerprint_algorithm = saml_setting.certificate_fingerprint_algorithm if saml_setting.certificate_fingerprint_algorithm.present?
    settings.name_identifier_format         = 'urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress'

    # Optional for most SAML IdPs
    settings.authn_context = 'urn:oasis:names:tc:SAML:2.0:ac:classes:Password'
    # # or as an array
    # settings.authn_context = [
    #   "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
    #   "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
    # ]

    # Optional bindings (defaults to Redirect for logout POST for acs)
    settings.single_logout_service_binding      = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect'
    settings.assertion_consumer_service_binding = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'

    settings
  end

  private

  def create_saml_setting
    SamlSetting.create!(account_id: id)
  end
end
