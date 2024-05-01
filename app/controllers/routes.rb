# Página inicial
get '/' do
  erb :index
end

# Rota de encurtamento
post '/encurtando' do
  
  url_original = params[:url_original]
  nova_url = generate_code()

  URLs[nova_url] = url_original

  "A URL encurtada é : #{request.base_url}/#{nova_url}"
end

# Redirecionamento
get '/:nova_url' do |nova_url|
  url_original = URLs[nova_url]
  if url_original
      redirect url_original
  else
      status 404
      "URL não encontrada"
  end
end