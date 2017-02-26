# coding: utf-8
require 'twitter'

class GalleryController < ApplicationController
  layout 'gallery'
  before_action :twitter_client, except: :new
  
  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "3LKb8kM3bANeDWuHVM9c4bvUy"
      config.consumer_secret     = "qKIMMySNZKIL8CFMuPmi7bb3sjEo06RLKhNcl6YSp7mrBLw2TB"
      config.access_token        = "833207117288910848-iTn16mQXmBBv1bv5J1p04dbxGAohuij"
      config.access_token_secret = "tUlT1lE81VQJBeqhADXl3U3UQp9WXFphCyfFjgynkZzYe"
    end
  end
  
  def index
    update_illusts
    @illust_data = Illust.all
    @header_pic_url = Illust.where("tags like ?", "%#header%").sample.pic_url
  end

  def about
    
  end

  def member
    
  end

  def update_illusts
    @client.search("#fun_illustrator exclude:retweets", count: 10).each do |tweet|
      if tweet.media?
        Illust.find_or_create_by(tweet_id: tweet.id) do |illust|
          illust.tweet_id = tweet.id.to_s
          illust.pic_url  = tweet.media.first.media_url
          illust.account  = tweet.user.screen_name
          illust.comment  = ""
          illust.tags     = ""
          tweet.text.split(" ").each do |text|
            if text.slice(0) == '#'
              illust.tags << text
            elsif text.slice(0, 12) == "https://t.co"
              # remove pic_url
            else
              illust.comment << text
            end
          end
        end
      end
    end
  end
  
end
