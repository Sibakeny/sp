# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :check_signed_in

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @account = @user.account

    if @account.saml_setting.inactive?
      if @user.present?
        sign_in(user: @user)
        redirect_to users_path
      else
        render :new, alert: 'ログイン失敗'
      end
    else
      request = OneLogin::RubySaml::Authrequest.new
      redirect_to(request.create(@account.saml_attributes(user: @user)))
    end
  end

  def destroy
    sign_out
    redirect_to new_sessions_path
  end
end
