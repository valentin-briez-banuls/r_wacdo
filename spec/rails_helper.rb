require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'active_record/railtie'  # ✅ Ajoute cette ligne si tu as l'erreur

# Assure-toi que les migrations sont à jour
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # ActiveRecord est utilisé pour gérer les fixtures et DB de test
  config.use_active_record = true

  # Spécifie le chemin des fixtures (si tu en utilises)
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
