namespace :jobs do
  task :work => :environment do
    loop do
      RespondJob.perform
      sleep 120
    end
  end
end