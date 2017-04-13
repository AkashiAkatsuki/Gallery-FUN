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
    update
    @illust_data = Illust.all
    headers = Illust.where("tags like ?", "%#header%")
    @header_pic_url = (headers.nil?)? "" : headers.sample.pic_url
  end

  def about
    
  end

  def member
    @member_data = Member.all
  end
  
  def illust
    unless params['tweet_id'].nil?
      data = Illust.where("tweet_id =  ?", params['tweet_id'])
      @data = data.first unless data.nil?
    end
  end
  
  def search
    unless params['keywords'].nil?
      @illust_data = Illust.where("tags like ?", '%' + params['keywords'] + '%')
    else
      @illust_data = Illust.all
    end
    @page = (params['page'].nil?)? 1 : params['page']
  end
  
  def update
    begin
      @client.search("#fun_illustrator exclude:retweets", count: 10 ).each do |tweet|
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
    @client.following.each do |user|
      Member.find_or_create_by(account: user.screen_name) do |member|
        member.name = user.name
        member.memo = ""
      end
    end
  rescue Twitter::Error::TooManyRequests => e
  end
  
end
