# Loads encryption keys from config/encryption_keys.yml (created by bin/setup).
# See README — keys must stay with your database backup.
keys_path = Rails.root.join("config/encryption_keys.yml")
if keys_path.exist?
  keys = YAML.load_file(keys_path).fetch(Rails.env)
  cfg = Rails.application.config.active_record.encryption
  cfg.primary_key = keys["primary_key"]
  cfg.deterministic_key = keys["deterministic_key"]
  cfg.key_derivation_salt = keys["key_derivation_salt"]
end
