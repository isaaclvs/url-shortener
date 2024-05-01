def generate_code()
  code = ''
  possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
  5.times do
      code += possible[rand(possible.length)]
  end

  return code
end