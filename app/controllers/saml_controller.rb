# frozen_string_literal: true

class SamlController < ApplicationController
  skip_before_action :check_signed_in
  skip_forgery_protection only: :consume

  before_action :set_account, only: [:consume, :metadata]

  def login; end

  def sso
    @user = User.find_by(email: params[:email])

    # saml設定がアクティブの場合はauthn requestを出す
    request_auth_request(@user) and return if @user.present? && @user.account.saml_setting.active?
  end

  def consume
    saml_authenticate_user!
  end

  def metadata
    meta = OneLogin::RubySaml::Metadata.new
    send_data meta.generate(@account.saml_attributes), type: 'application/samlmetadata+xml', filename: 'metadata.xml'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end
end
