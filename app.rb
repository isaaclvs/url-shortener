require 'sinatra'
require 'sinatra/tailwind'
require './db.rb'

class Url < Sequel::Model(:urls)
end

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/shorten' do
    url = params[:url]
    redirect '/'
  end
end
