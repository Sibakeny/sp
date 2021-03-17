# frozen_string_literal: true

class SamlController < ApplicationController
  skip_before_action :check_signed_in
  skip_forgery_protection only: :consume

  before_action :set_account

  def consume
    saml_response = Base64.decode64(params[:SAMLResponse])
    response = OneLogin::RubySaml::Response.new(saml_response, settings: @account.saml_attributes, skip_subject_confirmation: true)

    if response.is_valid?
      user = User.find_by(email: response.nameid)
      sign_in(user: user)
      redirect_to root_path
    else
      logger.error response.errors
    end
  end

  def metadata
    meta = OneLogin::RubySaml::Metadata.new
    render xml: meta.generate(@account.saml_attributes), content_type: 'application/samlmetadata+xml'
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end
end
