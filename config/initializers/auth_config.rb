config_file = File.join(Rails.root, 'config', 'omniauth.yml')
AuthConfig = (YAML::load_file config_file)[Rails.env]
