require 'bundler/setup'
require 'sinatra'
require 'require_all'

module Modules

end

require_all 'modules'

get '/' do
  'hi'
end
