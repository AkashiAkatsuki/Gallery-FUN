# coding: utf-8
require 'twitter'

class GalleryController < ApplicationController
  layout 'gallery'
  before_action :twitter_client, except: :new
  
  def twitter_client
    client_data = Client.first
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = client_data.consumer_key
      config.consumer_secret     = client_data.consumer_secret
      config.access_token        = client_data.access_token
      config.access_token_secret = client_data.access_token_secret
    end
  end
  
  def index
    update
    @illust_data = Illust.all
    @board = Board.all
    set_header
  end

  def about
    set_header
  end

  def member
    @member_data = Member.all
    set_header
  end
  
  def illust
    unless params['tweet_id'].nil?
      data = Illust.where("tweet_id = ?", params['tweet_id'])
      @data = data.first unless data.nil?
    end
    set_header
  end
  
  def search
    unless params['keywords'].nil?
      str = '%' + params['keywords'] + '%'
      @illust_data = Illust.where("(tags like ?) OR (comment like ?) OR (account like ?)", str, str, str)
    else
      @illust_data = Illust.all
    end
    @page = (params['page'].nil?)? 1 : params['page'].to_i
    set_header
  end
  
  def update
    begin
      # update illusts
      @client.search("#fun_illustrator exclude:retweets", count: 10 ).each do |tweet|
        if tweet.media?
          Illust.find_or_create_by(tweet_id: tweet.id) do |illust|
            illust.tweet_id = tweet.id.to_s
            illust.pic_url  = tweet.media.collect {|media| media.media_url}.join(" ")
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
    # update members
    @client.following.each do |user|
      Member.find_or_create_by(account: user.screen_name) do |member|
        member.name = user.name
        member.memo = ""
      end
    end
    # update board
    @client.mentions_timeline.each do |tweet|
      if(Member.exists?(:account => tweet.user.screen_name))
        Board.find_or_create_by(tweet_id: tweet.id) do |board|
          board.text = tweet.text
          board.text.slice!("@fun_illustrator ")
          board.account = tweet.user.screen_name
        end
      end
    end
  rescue Twitter::Error::TooManyRequests => e
  rescue Twitter::Error::ServiceUnavailable => e
  end

  def set_header
    headers = Illust.where("tags like ?", "%#header%")
    @header_pic_url = (headers.nil?)? "" : headers.sample.pic_url.first
  end

  def yosami
    illust = Illust.find(params[:id])
    p illust.comment
    illust.yosami = 0 if illust.yosami.nil?
    illust.yosami += 1
    illust.save  
  end

end
