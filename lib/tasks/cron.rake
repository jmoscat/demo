task :run => :environment do
  DemoIese.get_tweets
end