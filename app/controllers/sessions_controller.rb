# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :check_signed_in

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    # saml設定がアクティブの場合はauthn requestを出す
    request_auth_request(@user) and return if @user.present? && @user.account.saml_setting.active?

    if @user.present?
      sign_in(user: @user)
      redirect_to root_path
    else
      render :new, alert: 'ログイン失敗'
    end
  end

  def destroy
    sign_out
    redirect_to new_sessions_path
  end
end
