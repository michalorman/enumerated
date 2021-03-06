require 'active_record'
require 'enumerated'
require 'fixtures/models'
require 'matchers'

ActiveRecord::Base.establish_connection({'adapter' => 'sqlite3', 'database' => ':memory:'})

connection = ActiveRecord::Base.connection

connection.create_table(:users, :force => true) do |t|
  t.string :gender
  t.string :hair
  t.string :nationality
end

connection.create_table(:dogs, :force => true) do |t|
  t.string :name
end