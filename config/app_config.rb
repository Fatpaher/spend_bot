require 'logger'
require './config/database_connection'

class AppConfig
  def self.env
    ENV['RACK_ENV'] ||= 'development'
  end

  def self.test_env?
    env == 'test'
  end

  def self.production_env?
    env == 'production'
  end

  def configure
    setup_i18n
    setup_database
  end

  def get_token
    if self.class.production_env?
      return ENV['TELEGRAM_BOT_TOKEN']
    end
    secrets = YAML::load(IO.read('config/secrets.yml'))
    secrets[self.class.env]['telegram_bot_token']
  end

  def get_logger
    Logger.new(STDOUT, Logger::DEBUG)
  end

  private

  def setup_i18n
    I18n.load_path = Dir['config/locales.yml']
    I18n.locale = :en
    I18n.backend.load_translations
  end

  def setup_database
    DatabaseConnector.establish_connection
  end
end
