require 'fixtures/helpers'

I18n.load_path << File.join(File.dirname(__FILE__), '..', '..', 'locales', 'en.yml')

class User < ActiveRecord::Base
  enumerated :gender, [:male, :female]
  enumerated :hair, {black: "Black hair", brown: "Brown hair", red: "Red hair", blond: "Blond hair"}, :helper => HairsHelper, :validate => false
  enumerated :nationality, %w(gbr esp pol), :helper => false
end