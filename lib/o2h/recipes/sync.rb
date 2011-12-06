_cset(:sync_db_via) { :scp }
_cset(:sync_db_file) { "#{application}-dump.sql.gz" }
_cset(:sync_db_remote_file) { "#{shared_path}/backup/#{sync_db_file}" }
_cset(:sync_db_remote_config) { "#{shared_path}/config/database.yml" }
_cset(:sync_db_local_file) { "tmp/#{sync_db_file}" }
_cset(:sync_db_local_config) { "config/database.yml" }

namespace :sync do

  namespace :db do
    #
    # Reads the database credentials from the local config/database.yml file
    # +db+ the name of the environment to get the credentials for
    # Returns config hash
    #
    def database_config(db = rails_env)
      database = YAML::load_file(sync_db_local_config)
      database and database["#{db}"]
    end

    #
    # Reads the database credentials from the remote config/database.yml file
    # +db+ the name of the environment to get the credentials for
    # Returns username, password, database
    #
    def remote_database_config(db = rails_env)
      remote_config = capture("cat #{sync_db_remote_config}")
      database = YAML::load(remote_config)
      database and database["#{db}"]
    end

    desc "Dump, fetch and import remote database to local"
    task :default do
      dump
      fetch
      import
    end

    desc "Dump remote database to :sync_db_file"
    task :dump do
      file = sync_db_file
      remote_file = sync_db_remote_file

      remote = remote_database_config

      raise "remote database config not found" unless remote

      require 'pg_dumper'

      pg = PgDumper.new(remote["database"], 'pg_dump')
      pg.output = remote_file
      pg.clean!
      pg.compress! 9
      pg.auth = remote

      run pg.command
    end

    desc "Import database from :sync_db_local_file"
    task :import do
      local = database_config
      raise "local database config not found" unless local

      pg = PgDumper.new(local["database"], "psql")
      pg.auth = local

      run_locally "gunzip --stdout #{sync_db_local_file} | #{pg.command}"
    end

    task :fetch do
      download sync_db_remote_file, sync_db_local_file, :via => sync_db_via
    end
  end
end


