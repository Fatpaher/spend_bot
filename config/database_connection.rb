require 'active_record'
require 'logger'

class DatabaseConnector
  class << self
    def establish_connection
      ActiveRecord::Base.logger = Logger.new(active_record_logger_path)

      ActiveRecord::Base.establish_connection(configuration)
    end

    def configuration
      return ENV['DATABASE_URL'] if AppConfig.production_env?

      YAML.safe_load(IO.read(database_config_path))[AppConfig.env]
    end

    private

    def active_record_logger_path
      'debug.log'
    end

    def database_config_path
      'config/database.yml'
    end
  end
end
