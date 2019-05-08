require 'pg'
require 'active_record'
require 'yaml'

namespace :db do
  enviromvent = ENV['RACK_ENV'] || 'development'
  db_config = YAML::load(File.open('config/database.yml'))[enviromvent]
  db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.create_database(db_config["database"])
    puts "Database created."
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::MigrationContext.new("db/migrate/").migrate
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc 'Rollback the database'
  task :rollback, [:steps] do |_task, args|
    steps = (args[:steps] || 1).to_i

    ActiveRecord::Base.establish_connection(DATABASE_CONFIG)
    ActiveRecord::Migrator.rollback(['db/migrate'], steps)

    Rake::Task['db:schema'].invoke
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted."
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end
end
