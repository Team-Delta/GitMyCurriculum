# Set up script for development on personal computers
# Do not use this to run the server every time
# Usage is for when you pull down big changes
# Make sure sunspot is running before you run this script

namespace :dev_setup do
  desc "Running sunspot"
  task sunspot: :environment do

    puts ''
    puts '#############################################'
    puts 'starting sunspot solr....'
    puts '#############################################'
    puts ''

    Rake::Task['sunspot:solr:start'].invoke

  end

  desc "Drop, create, and migrate database"
  task migrate: :environment do

    puts ''
    puts '#############################################'
    puts 'droping, creating, and migrating database....'
    puts '#############################################'
    puts ''

    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

  end

  desc "Seed database with fixtures"
  task seed: :environment do

    puts ''
    puts '#############################################'
    puts 'seeding database with fixtures from db/fixtures/....'
    puts '#############################################'
    puts ''

    Rake::Task['db:seed_fu'].invoke

  end

  desc "Reindex sunspot search"
  task reindex: :environment do

    puts ''
    puts '#############################################'
    puts 'starting sunspot reindex....'
    puts '#############################################'
    puts ''

    Rake::Task['sunspot:reindex'].invoke

  end

  desc "Run rails server"
  task runserver: :environment do

    puts ''
    puts '#############################################'
    puts 'starting rails server....'
    puts '#############################################'
    puts ''

    system('rails s')

  end

  desc "Run all dev setup tasks"
  task run_all: :environment do

    # Rake::Task['dev_setup:sunspot'].invoke
    Rake::Task['dev_setup:migrate'].invoke
    Rake::Task['dev_setup:seed'].invoke
    Rake::Task['dev_setup:reindex'].invoke
    Rake::Task['dev_setup:runserver'].invoke

  end

end
