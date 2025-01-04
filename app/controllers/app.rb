require 'sinatra'
require 'sinatra/tailwind'

class App < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)

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
    if url
      url.increment_access_count!
      redirect url.original_url
    else
      redirect '/'
    end
  end
end
