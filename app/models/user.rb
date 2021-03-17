# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :account
end
# settings.idp_entity_id                  = saml_setting.entity_id
# settings.idp_sso_service_url            = saml_setting.sso_url
# settings.idp_slo_service_url            = saml_setting.slo_url
# settings.idp_cert_fingerprint           = saml_setting.certificate_fingerprint
# settings.idp_cert_fingerprint_algorithm = saml_setting.certificate_fingerprint_algorithm
# settings.name_identifier_format         = saml_setting.name_id_format

# # Optional for most SAML IdPs
# settings.authn_context = saml_setting.authn_context
#
# # or as an array
# settings.authn_context = [
#   "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
#   "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
# ]

# Optional bindings (defaults to Redirect for logout POST for acs)
# settings.single_logout_service_binding      = saml_setting.slo_http_binding
# settings.assertion_consumer_service_binding = saml_setting.sso_http_binding

#   settings = OneLogin::RubySaml::Settings.new

#   settings.assertion_consumer_service_url = "http://#{request.host}/saml/consume"
#   settings.sp_entity_id                   = "http://#{request.host}/saml/metadata"
#   settings.idp_entity_id                  = "https://app.onelogin.com/saml/metadata/#{OneLoginAppId}"
#   settings.idp_sso_service_url             = "https://app.onelogin.com/trust/saml2/http-post/sso/#{OneLoginAppId}"
#   settings.idp_slo_service_url             = "https://app.onelogin.com/trust/saml2/http-redirect/slo/#{OneLoginAppId}"
#   settings.idp_cert_fingerprint           = OneLoginAppCertFingerPrint
#   settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2000/09/xmldsig#sha1"
#   settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

#   # Optional for most SAML IdPs
#   settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
#   # or as an array
#   settings.authn_context = [
#     "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
#     "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
#   ]

#   # Optional bindings (defaults to Redirect for logout POST for acs)
#   settings.single_logout_service_binding      = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"
#   settings.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"

#   settings
