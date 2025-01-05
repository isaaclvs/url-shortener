require_relative '../db/db'

DB.create_table? :urls do
  primary_key :id
  String :original_url, null: false
  String :short_code, null: false, unique: true
  DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
  Integer :access_count, default: 0
  
  index :short_code
end
