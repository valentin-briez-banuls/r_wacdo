# config/environments/production.rb

Rails.application.configure do
  # Cache classes to améliorer la performance
  config.cache_classes = true

  # Charge tout à l'avance
  config.eager_load = true

  # Ne pas afficher les erreurs détaillées à l'utilisateur final
  config.consider_all_requests_local = false

  # Active la gestion des fichiers statiques si variable d'environnement présente
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Ne pas compiler les assets à la volée en production (faire un precompile avant déploiement)
  config.assets.compile = false

  # Niveau de logs
  config.log_level = :info

  # Exemple configuration email (à adapter)
  # config.action_mailer.perform_caching = false
  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address: ENV['SMTP_ADDRESS'],
  #   port: 587,
  #   user_name: ENV['SMTP_USERNAME'],
  #   password: ENV['SMTP_PASSWORD'],
  #   authentication: 'plain',
  #   enable_starttls_auto: true
  # }
end
