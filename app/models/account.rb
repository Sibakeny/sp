# frozen_string_literal: true

class Account < ApplicationRecord
  has_one :saml_setting
end
