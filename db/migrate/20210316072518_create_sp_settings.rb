class CreateSpSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :sp_settings do |t|
      t.string :sso_url
      t.string :slo_url
      t.string :x509_certificate
      t.string :certificate_fingerprint
      t.string :certificate_fingerprint_algorithm
      t.string :name_id_format
      t.string :sso_http_binding
      t.string :slo_http_binding
      t.string :authn_context
      t.timestamps
    end
  end
end
