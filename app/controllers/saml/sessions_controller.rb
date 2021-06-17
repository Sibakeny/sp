# frozen_string_literal: true

module Saml
  class SessionsController < SessionsBaseController
    skip_before_action :check_signed_in
    # GET /saml/sign_in
    # def new
    #   super
    # end

    # POST /saml/sign_in
    # def create
    #   super
    # end
  end
end
