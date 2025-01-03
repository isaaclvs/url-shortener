require 'sinatra'
require 'sinatra/tailwind'
require './db'
require './models/url'

class App < Sinatra::Base
  get '/' do
    @urls = Url.reverse_order(:created_at).limit(5)
    erb :index
  end

  post '/shorten' do
    url = Url.create(original_url: params[:url])
    redirect '/'
  end

  get '/:short_code' do
    url = Url.first(short_code: params[:short_code])
    redirect url.original_url if url
    redirect '/'
  end
end
