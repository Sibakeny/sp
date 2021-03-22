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

    if @saml_setting.update(saml_setting_params)
      redirect_to saml_settings_path
    else
      render :edit
    end
  end

  private

  def saml_setting_params
    params.require(:saml_setting).permit(:sso_url, :slo_url, :x509_certificate, :certificate_fingerprint, :entity_id,
                                         :certificate_fingerprint_algorithm, :name_id_format, :authn_context, :status)
  end
end