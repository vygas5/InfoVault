namespace :encryption do
  desc "Generate config/encryption_keys.yml for Active Record Encryption"
  task setup: :environment do
    require "securerandom"

    path = Rails.root.join("config/encryption_keys.yml")
    if path.exist?
      puts "config/encryption_keys.yml already exists — delete it first to regenerate."
      next
    end

    def random_key
      SecureRandom.hex(32)
    end

    keys = {
      "primary_key" => random_key,
      "deterministic_key" => random_key,
      "key_derivation_salt" => random_key
    }
    content = {
      "development" => keys,
      "test" => keys.transform_values { |v| "#{v}-test" }
    }
    File.write(path, content.to_yaml)
    puts "Wrote #{path} — back this up with your database files."
  end
end
