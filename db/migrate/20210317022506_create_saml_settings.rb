# frozen_string_literal: true

class CreateSamlSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :saml_settings do |t|
      t.string :sso_url
      t.string :slo_url
      t.string :x509_certificate
      t.string :certificate_fingerprint
      t.string :certificate_fingerprint_algorithm
      t.string :entity_id
      t.integer :status, default: 0
      t.references :account
      t.timestamps
    end
  end
end
