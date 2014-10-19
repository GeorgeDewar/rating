require 'bundler/setup'
require 'sinatra'
require 'require_all'
require 'json'
require 'httparty'
require 'nokogiri'
require 'pry'
require 'pp'

module Modules

end

require_all 'modules'
include Modules

get '/search' do
  LowerHutt.new.get_info(params[:q]).to_json
end
