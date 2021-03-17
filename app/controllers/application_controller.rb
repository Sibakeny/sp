# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :check_signed_in

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_signed_in
    p @current_user
    p current_user
    redirect_to new_sessions_path unless signed_in?
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user:)
    @current_user = user
    session[:user_id] = @current_user.id
    p @current_user
  end

  def sign_out
    @current_user = nil
    session[:user_id] = nil
  end
end
