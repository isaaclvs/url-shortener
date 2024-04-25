# Url Shortener

url = 'https://pt.wikipedia.org/wiki/Hist%C3%B3ria_do_Egito'

def generate_code()
    code = ''
    possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
    5.times do
        code += possible[rand(possible.length)]
    end

    return code
end

url_short = "http://localhost:3000/#{generate_code()}"

puts url_short