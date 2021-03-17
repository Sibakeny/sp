class SpSettingsController < ApplicationController

  def show
    @sp_setting = SpSetting.find_or_create_by(user_id: User.first.id)
  end

  def edit
    @sp_setting = SpSetting.find_or_create_by(user_id: User.first.id)
  end

  def update
    @sp_setting = SpSetting.find_by(user_id: User.first.id)

    @sp_setting.update(sp_setting_params)
  end

  private

  def sp_setting_params
    params.require(:sp_setting).permit(:sso_url, :slo_url, :x509_certificate, :certificate_fingerprint, :certificate_fingerprint_algorithm, :name_id_format, :sso_http_binding, :slo_http_binding, :authn_context)
  end
end
