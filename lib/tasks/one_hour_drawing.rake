namespace :one_hour_drawing do

  client = nil

  task :auth => :environment do
    client_data = Client.first
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = client_data.consumer_key
      config.consumer_secret     = client_data.consumer_secret
      config.access_token        = client_data.access_token
      config.access_token_secret = client_data.access_token_secret
    end
  end

  task :announce => :auth do
    if [2, 5].include? Date.today.wday
      themes = Theme.all.shuffle.first(3)
      client.update "ワンドロの時間です。本日のお題は「" + themes[0].name + "」「" + themes[1].name + "」「" + themes[2].name + "」から選んでください。"
    end
  end

end
