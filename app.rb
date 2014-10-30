require 'bundler/setup'
require 'sinatra'
require 'require_all'
require 'json'
require 'httparty'
require 'nokogiri'
require 'pry'
require 'pp'
require 'ostruct'

module Modules
  def self.modules_matching(address)
    modules.select { |m| m.matches address }
  end

  private

  def self.modules
    self.constants.select {|c| Class === self.const_get(c)}.map{ |c| const_get(c) }
  end
end

require_all 'modules'
include Modules

get '/search' do
  content_type :json

  address = OpenStruct.new({
    address: normalise_address(params[:address]),
    suburb: params[:suburb],
    city: params[:city]
  })

  search_module = Modules.modules_matching(address).first
  return {error: :region_not_supported}.to_json unless search_module

  (search_module.new.get_info(address)).merge({source: search_module.to_s.split('::').last, source_name: search_module.name}).to_json
end

private

def normalise_address(address)
  address.split.map(&:capitalize).join(' ')
end
