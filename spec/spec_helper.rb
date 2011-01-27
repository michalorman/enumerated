require 'active_record'
require 'enumerated'
require 'fixtures/models'

ActiveRecord::Base.establish_connection({'adapter' => 'sqlite3', 'database' => ':memory:'})

connection = ActiveRecord::Base.connection

connection.create_table(:user_defaults, :force => true) do |t|
  t.string :gender
end