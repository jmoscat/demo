class DemoIese < ActiveRecord::Base
	 def self.get_tweets
    #TweetStream API used to track keywords related to thanx, and checks first for the english language being used
    thanx = TweetStream::Client.new
    thanx.on_delete do |status_id, user_id|
      puts "TWEEID: #{status_id} --- #{user_id}"
      #ErrorMailer.error_mail(status_id).deliver
    end
    thanx.on_limit do |skip_count|
      puts "SKIP: #{skip_count}"
      #ErrorMailer.error_mail(skip_count).deliver
    end
    thanx.on_error do |message|
      puts "Error: #{message}"
      #ErrorMailer.error_mail(message).deliver
    end
    thanx.track('@_thanxup_') do |thanx|
      if thanx.text.present?
      	puts "#{thanx.text}"
        if check_if_valid(thanx)
          names = Twitter::Extractor.extract_mentioned_screen_names(thanx.text)
          if !name.index("test1").nil?
            client_1 = Client.where(:twitter_name => "test1")
            DemoIese.get_data(thanx, client_1.id)
          elsif !name.index("test2").nil?
            client_1 = Client.where(:twitter_name => "test2")
            DemoIese.get_data(thanx, client_1.id)
          end
        end
      end
    end
  end

  def self.get_data(thanx, client_id)
  	test_user = User.where(:twitter_user_id => thanx.user.id_str)
    test_tweet = Tweet.where(:tweet_id => thanx.id_str)
    if test_tweet.blank?
      new_tweet.tweet_id = thanx.id_str
      new_tweet.twitter_user_id = thanx.user.id_str
      new_tweet.tweet_text = thanx.text
      new_tweet.save
    end
  	if test_user.blank?
  		new_user = User.new
  		new_user.twitter_user_id = thanx.user.id_str
  		#new_user.tweet_text = DemoIese.check_for_elements_and_replace(thanx.text)
      new_user.ratio = DemoIese.obtain_ratio(thanx.user)
      new_user.tweet_username = thanx.user.screen_name
      new_user.tweet_user_link = "http://www.twitter.com/#{thanx.user.screen_name}"
      followers_and_tweets_amount = DemoIese.get_tweet_user_information(thanx.user)
      new_user.tweet_user_number_followers = followers_and_tweets_amount[0]
      new_user.tweet_user_average_tweets_day = followers_and_tweets_amount[1]
      new_user.tweet_user_number_following = followers_and_tweets_amount[2]
      new_user.listed_count = followers_and_tweets_amount[3]
      new_user.tweet_location = followers_and_tweets_amount[4]
      new_user.profile_null = followers_and_tweets_amount[5]
      new_user.retweet_count = DemoIese.avg_last_7_rts(thanx.user.screen_name)
      new_user.verified = thanx.user.verified
      new_user.geo_location = thanx.geo
      new_user.save
      DemoIese.ranking_algorithm(new_user, new_user.verified)
      DemoIese.check_visit(client_id, new_user.id)
    else
      DemoIese.check_visit(client_id, test_user.id)
      test_user.retweet_count = DemoIese.avg_last_7_rts(test_user.tweet_username)
      DemoIese.ranking_algorithm(test_user, test_user.verified)
    end
  end

  def self.check_visit(client_id, user_id)
    visit = Visit.where("user_id = ? AND client_id = ?", user_id, client_id)
    if visit.blank?
      new_visit = Visit.new
      new_visit.user_id = user_id
      new_visit.client_id = client_id
      new_visit.save
      new_join = UserClientJoin.new
      new_join.user_id = user_id
      new_join.client_id = client_id
      new_join.save
    elsif (((Time.now - visit.updated_at).to_i)/86400) >= 8
      new_visit = Visit.new
      new_visit.user_id = user_id
      new_visit.client_id = client_id
      new_visit.save
    end
  end

  def self.create_send_cupon(user_id,client_id)
    url = Discount.generate_cupon(user_id,client_id)
    user_name = User.where(:user_id => user_id).tweet_username
    #Send tweet

  end


  def self.avg_last_7_rts (username)
    count = 0
  	tweets = Twitter.user_timeline(username, :count =>7)
    tweets.each do |x|
      count = count + x.retweet_count
    end
    return count/tweets.size
  end

  def self.check_if_valid(tweet)
    if !tweet[:entities][:hashtags].blank?
      tweet[:entities][:hashtags].each do |x|
        if (x.text =~ /(thnxup)/)
          regex = Regexp.new (/(\d+)/)
          mt = regex.match(x.text)
          return true
        else
          return false
        end   
      end
    end
  end

  	#Twitter.search("@JoseCabiedes until:2012-10-01-03", :result_type => "recent").results.map do |status|
  	#"#{status.from_user}: #{status.text}" 
  	#end

  	#Twitter.search("@JoseCabiedes since:2012-10-01").results.map do |status|

  def self.ranking_algorithm(user, verified)
    if verified || user.ratio == 11
      user_score = 32.0
    else
      #user attributes
      number_of_followers = get_followers_rank(user.tweet_user_number_followers)
      average_count = get_average_tweets_day_rank(user.tweet_user_average_tweets_day)
      ratio_of_follow = get_ratio_rank(user.ratio)
      listed_count = get_listed_count_rank(user.listed_count)
      has_null_profile = get_profile_rank(user.profile_null)
      retweet = get_retweet_rank(user.retweet_count)
      user_score = retweet + number_of_followers + average_count + ratio_of_follow + listed_count + has_null_profile
    end
    user.influence = (user_score/32.0)*100.0
    user.save
  end
  #Takes the user information portion of the TweetStream object, and we
  #find and calculate criteria such as the number of tweets, number of
  #followers, number of following, location, average tweet/day, etc.
  def self.get_tweet_user_information(user)
    user_followers_and_tweets = []
    user_date_created_at = user[:created_at].to_date.mjd
    number_of_tweets = user[:statuses_count]
    user_followers_and_tweets << user[:followers_count]
    profile_age = (Date.today.mjd - user_date_created_at).to_f
    if profile_age == 0.0
      user_followers_and_tweets << number_of_tweets.to_f
    else
      user_followers_and_tweets << (number_of_tweets.to_f/((Date.today.mjd - user_date_created_at).to_f))
    end
    user_followers_and_tweets << user[:friends_count]
    user_followers_and_tweets << user[:listed_count]
    user_followers_and_tweets << user[:location]
    if !user[:description].blank? #User filled out their profile
      user_followers_and_tweets << false
    else
      user_followers_and_tweets << true
    end
    return user_followers_and_tweets
  end

  def self.check_for_elements_and_replace(text)
    return Twitter::Autolink.auto_link(text, :target => "_blank")
  end

  def self.contains_link(tweet)
    !tweet[:entities][:urls].blank? ? true : false
  end

  def self.obtain_ratio(tweet_user)
    if tweet_user[:followers_count] == 0 || tweet_user[:friends_count] == 0
      return 0
    else
      return (tweet_user[:followers_count].to_f/tweet_user[:friends_count].to_f)
    end
  end

  def self.get_followers_rank(followers)
    case followers
      when 0 then
        return 0
      when 0..10 then
        return 1
      when 10..126 then
        return 2
      when 126..500 then
        return 3
      else
        return 4
    end
  end

  def self.get_retweet_rank(retweet)
    case retweet
      when 0 then
        return 0
      when 0..1 then
        return 1
      when 1..4 then
        return 2
      when 4..7 then
        return 3
      when 7..11 then
        return 4
      when 11..16 then
        return 5
      else
        return 6
    end
  end

  def self.get_average_tweets_day_rank(average)
    case average
      when 0 then
        return 0
      when 0..0.1 then
        return 1
      when 0.1..3 then
        return 2
      when 3..5 then
        return 3
      when 5..10 then
        return 4
      when 10..20 then
        return 2
      else
        return 1
    end
  end

  def self.get_profile_rank(profile)
    case profile
      when false then
        return 1
      else
        return 0
    end
  end

  def self.get_listed_count_rank(listed_count)
    case listed_count
      when 0 then
        return 0
      when 0..3 then
        return 1
      when 3..7 then
        return 2
      when 7..12 then
        return 3
      when 12..18 then
        return 4
      when 18..25 then
        return 5
      else
        return 6
    end
  end

  def self.get_ratio_rank(ratio)
    case ratio
      when 0 then
        return 0
      when 0..0.25 then
        return 1
      when 0.25..0.5 then
        return 2
      when 0.5..0.75 then
        return 3
      when 0.75..1 then
        return 4
      when 1..1.25 then
        return 5
      when 1.25..1.50 then
        return 6
      when 1.50..1.75 then
        return 7
      when 1.75..2 then
        return 8
      when 2..5.5 then
        return 9
      when 5.5..9 then
        return 10
      else
        return 11
    end
  end
end
