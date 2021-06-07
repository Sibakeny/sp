# frozen_string_literal: true

module Saml
  class SsosController < SsosBaseController
    skip_before_action :check_signed_in

    # POST /saml/sso/:id
    # def consume
    #   super
    # end

    # GET /saml/metadata/:id
    # def metadata
    #   super
    # end
  end
end
