require 'sequel'
require 'logger'

Sequel::Model.plugin :schema
Sequel.extension :core_extensions
Sequel::Database.extension :id_pagination

Sequel::Model.db = Sequel.connect('sqlite://development.db', logger: Logger.new(STDOUT))


Sequel::Model.db.create_table? :users do
  primary_key :id
  String :name
end
