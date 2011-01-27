require 'fixtures/helpers'

class User < ActiveRecord::Base
  enumerated :gender, [:male, :female]
  enumerated :hair, {black: "Black hair", brown: "Brown hair", red: "Red hair", blond: "Blond hair"}, :helper => HairsHelper
end