# frozen_string_literal: true

class SamlSetting < ApplicationRecord
  belongs_to :account

  enum status: { inactive: 0, active: 1 }
end
