# encoding: utf-8
require'oauth'
require 'oauth/consumer'
require 'uri'
require 'yajl'

class DoubanServicesController < ApplicationController
  #ApiKey = "035aeaad87c364fa0a10c008974a2eee"
  #ApiKeySecret = "ea6c88ff40b8dd79"
  ApiKey = "0a0a3710889939f41e1ea53199cbaddc"
  ApiKeySecret = "9764b31f80a15c1b"

  @@consumer=OAuth::Consumer.new(
                                ApiKey, 
                                ApiKeySecret, 
                                { 
                                  :site=>"http://www.douban.com",
                                  :request_token_path=>"/service/auth/request_token",
                                  :access_token_path=>"/service/auth/access_token",
                                  :authorize_path=>"/service/auth/authorize",
                                  :signature_method=>"HMAC-SHA1",
                                  :scheme=>:header,
                                  :realm=>"http://huacaor.com"
                                }
                              )

  # 豆瓣登录
  def new
    if session[:request_token]
      return redirect_to :action => "login"
    end

    @request_token=@@consumer.get_request_token
    session[:request_token] = @request_token

    callback_url = "http://127.0.0.1:3000/douban_services/login"

    redirect_to @request_token.authorize_url(:oauth_callback => callback_url)
  end

  # 豆瓣登录
  def login
    @access_token = session[:request_token].get_access_token

    url = "http://api.douban.com/people/@me?alt=json"
    url = URI.escape(url, '@')
    res = @access_token.get(url)
    logger.debug "res: #{res.body}"
    res = Yajl::Parser.parse(res.body)

    douban_uid = res["db:uid"]["$t"]
    #logger.debug "---res['title'] #{res['title']['$t']}----------"
    douban_name = res['title']['$t']

    u = User.where(:douban_uid => douban_uid).first
    if u.blank?
      u = User.new(
        :douban_uid => douban_uid,
        :douban_name => douban_name,
        :name => douban_name
      )
      u.save
    end

    session[:user_id] = u.id
    #ret_url = session[:return_to] || new_session_path
    #redirect_to root_path

    redirect_to root_path
  end
end
