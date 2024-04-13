require 'database_cleaner/active_record'

namespace :db do
  desc "Cleans database using Database Cleaner gem"
  task clean: :environment do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    puts "Database has been cleaned."
  end
end
