require 'fixtures/helpers'

class User < ActiveRecord::Base
  enumerated :gender, [:male, :female]
  enumerated :hair, {black: "Black hair", brown: "Brown hair", red: "Red hair", blond: "Blond hair"}, :helper => HairsHelper
end

#class UserDefined < ActiveRecord::Base
#  enumerated :gender, {:male => "Sir", :female => "Madam"}
#end
#
#class UserI18n < ActiveRecord::Base
#  enumerated :gender, [:male, :female]
#end