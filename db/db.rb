require 'dotenv/load'
require 'sequel'

DB = Sequel.connect(
  adapter: 'mysql2',
  host: ENV['DB_HOST'],
  database: ENV['DB_NAME'],
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD']
)
