namespace :test_setup do

  desc "Install project dependancies"
  task install: :environment do

    Rails.env = "test"

    puts ''
    puts '#############################################'
    puts 'getting project dependancies...'
    puts '#############################################'
    puts ''

    system('bundle install')

  end
  
  desc "Migrate database for test environment"
  task migrate: :environment do

    Rails.env = "test"

    puts ''
    puts '#############################################'
    puts 'droping, creating, and migrating database....'
    puts '#############################################'
    puts ''
    
    ActiveRecord::Base.establish_connection('test')
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

  end

  desc "Run tests for project"
  task tests: :environment do

    Rails.env = "test"

    puts ''
    puts '#############################################'
    puts 'Initializing tests.....'
    puts '#############################################'
    puts ''

    Rake::Task['spec'].invoke

  end

  desc "Run all test dependancies"
  task run_all: :environment do

    Rails.env = "test"

    Rake::Task['test_setup:install'].invoke
    system('rubocop -R')
    Rake::Task['test_setup:migrate'].invoke
    Rake::Task['test_setup:tests'].invoke

  end
  
end
