require 'sinatra'

URLs = {}

def generate_code()
    code = ''
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
    5.times do
        code += possible[rand(possible.length)]
    end

    return code
end

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


__END__


@@index
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Encurtador de Url</title>
</head>
<body>
    <h1>Seu encurtador de url</h1>
    <form action="/encurtando" method="post">
    <label for="url_original">Insira a URL:</label><br>
    <input type="text" id="url_original" name="url_original" /><br>
    <input type="submit" value="Encurtar" />
  </form>

</body>
</html>