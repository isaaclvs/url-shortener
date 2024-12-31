require_relative '../db'

DB.create_table :urls do
  primary_key :id
  String :original_url, null: false
  String :short_url, null: false
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
end

puts "Ok"

