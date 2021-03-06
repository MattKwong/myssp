#!/usr/bin/env ruby

module Heroku
  class Db < Thor
    method_option :keep,   :type => :boolean, :default => false
    method_option :remote, :type => :string,  :default => "myssp-cedar"
    method_option :host,   :type => :string,  :default => "localhost"
    method_option :user,   :type => :string,  :default => "rickeaton"
    method_option :dbname, :type => :string,  :default => 'myssp_development'
    method_option :dump,   :type => :string,  :default => "latest.dump"
    method_option :app,   :type => :string,   :default => 'myssp-cedar'

    desc "clone", "clone a remote heroku database to the local environment"
    def clone
      puts "Cloning production database to local environment. This might take a few minutes\n"
      puts "(1/4) capturing production database snapshot..."
      puts `heroku pgbackups:capture --expire --remote #{options[:remote]} --app #{options[:app]}`
      puts "(2/4) downloading snapshot..."
      puts `curl -o #{options[:dump]} \`heroku pgbackups:url --remote #{options[:remote]}  --app #{options[:app]}\``
      puts "(3/4) restoring snapshot..."
      puts `pg_restore --verbose --clean --no-acl --no-owner -h #{options[:host]} -U #{options[:user]} -d #{options[:dbname] || dbname} #{options[:dump]}`
      unless options[:keep]
        puts "(4/4) cleaning up..."
        puts `rm #{options[:dump]}`
      else
        puts "(4/4) skipping cleaning..."
      end
    end
    desc "push", "push the local myssp development db to a myssp-cedar"
    def push
      puts "Pushing the local dev db to production. This might take a few minutes\n"
      puts "(1/4) capturing local database snapshot..."
      puts `pg_dump -h localhost -U #{options[:user]}  -Fc #{options[:dbname]} > #{options[:dump]} `
      puts "(2/4) uploading snapshot..."
      unless options[:keep]
        puts "(4/4) cleaning up..."
        puts `rm #{options[:dump]}`
      else
        puts "(4/4) skipping cleaning..."
      end
    end

    no_tasks do
      def dbname
        YAML.load_file('config/database.yml')["development"]["database"]
      end
    end
  end
end

