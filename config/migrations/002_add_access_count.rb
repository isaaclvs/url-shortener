require_relative '../../db'

DB.alter_table :urls do
  add_column :access_count, Integer, default: 0
end 