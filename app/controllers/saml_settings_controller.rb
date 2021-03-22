# frozen_string_literal: true

class SamlSettingsController < ApplicationController
  def show
    @saml_setting = SamlSetting.find_by!(account_id: current_user.account_id)
    @account = current_user.account
  end

  def edit
    @saml_setting = SamlSetting.find_by!(account_id: current_user.account_id)
  end

  def update
    @saml_setting = SamlSetting.find_by!(account_id: current_user.account_id)

    @saml_setting.update(saml_setting_params)
  end

  private

  def saml_setting_params
    params.require(:saml_setting).permit(:sso_url, :slo_url, :x509_certificate, :certificate_fingerprint, :entity_id,
                                         :certificate_fingerprint_algorithm, :name_id_format, :sso_http_binding, :slo_http_binding, :authn_context, :status)
  end
end
