require 'sinatra'
require './db.rb'

class Url < Sequel::Model(:urls); end

get '/' do
  erb :index
end

post '/shorten' do
  original_url = params[:original_url]
  short_url = SecureRandom.hex(4)
  Url.create(original_url: original_url, short_url: short_url)
  "Shortened URL: #{short_url}"
end
