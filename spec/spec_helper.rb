require 'active_record'
require 'enumerated'
require 'fixtures/models'
require 'matchers'

I18n.load_path << File.join(File.dirname(__FILE__), '..', 'locales', 'en.yml')

ActiveRecord::Base.establish_connection({'adapter' => 'sqlite3', 'database' => ':memory:'})

connection = ActiveRecord::Base.connection

connection.create_table(:users, :force => true) do |t|
  t.string :gender
  t.string :hair
  t.string :height
end