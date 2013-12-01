rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'


require rails_root.to_s + '/lib/jobs/respond_job.rb'