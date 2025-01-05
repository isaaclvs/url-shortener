require 'sinatra'
require 'sinatra/tailwind'
require_relative '../models/url'

class App < Sinatra::Base
  register Sinatra::Tailwind
  
  set :public_folder, File.expand_path('../../public', __dir__)
  set :views, File.expand_path('../views', __dir__)

  get '/' do
    @urls = Url.reverse_order(:created_at).limit(5)
    erb :index
  end

  post '/shorten' do
    Url.create(original_url: params[:url])
    redirect '/'
  end

  get '/:short_code' do
    url = Url.first(short_code: params[:short_code])
    if url
      url.increment_access_count!
      redirect url.original_url
    else
      redirect '/'
    end
  end
end
