namespace :tweets do
  desc "Refreshes recent tweets for all contacts"
  task :refresh => :environment do
    Contact.tweeple.each do |tweep|
      tweep.refresh_tweets
    end
  end
end