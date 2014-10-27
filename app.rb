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
  address = {
    address: normalise_address(params[:address]),
    suburb: params[:suburb],
    city: params[:city]
  }

  content_type :json
  LowerHutt.new.get_info(address).to_json
end

private

def normalise_address(address)
  address.split.map(&:capitalize).join(' ')
end
