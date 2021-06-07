# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :check_signed_in

  # # samlで認証リクエスト
  # def request_auth_request(user)
  #   request = OneLogin::RubySaml::Authrequest.new
  #   redirect_to(request.create(user.account.saml_attributes(user: user)))
  # end

  # # saml responseを検証しログイン
  # def saml_authenticate_user!
  #   saml_response = Base64.decode64(params[:SAMLResponse])
  #   response = OneLogin::RubySaml::Response.new(saml_response, settings: @account.saml_attributes, skip_subject_confirmation: true)

  #   if response.is_valid?
  #     # nameid formatの確認も挟んだ方が良い？
  #     # 設定ファイルでnameidとどのモデルのどのカラムが紐づくかを記載する形でライブラリを作ることになると思う
  #     user = User.find_by(email: response.nameid)
  #     sign_in(user: user)
  #     redirect_to root_path
  #   else
  #     raise response.errors.join(',')
  #   end
  # end

  def sign_in_with_saml(user)
    sign_in(user: user)
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_signed_in
    redirect_to new_sessions_path unless signed_in?
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user:)
    @current_user = user
    session[:user_id] = @current_user.id
  end

  def sign_out
    @current_user = nil
    session[:user_id] = nil
  end
end
