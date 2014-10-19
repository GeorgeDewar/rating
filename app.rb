require 'bundler/setup'
require 'sinatra'
require 'require_all'
require 'json'
require 'httparty'

module Modules

end

require_all 'modules'
include Modules

get '/search' do
  WatchMyStreet.new.get_info(params[:q])
end
