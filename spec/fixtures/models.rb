require 'fixtures/helpers'

class User < ActiveRecord::Base
  enumerated :gender, [:male, :female]
  enumerated :hair, [:black, :brown, :red, :blond], :helper => HairsHelper
end

#class UserDefined < ActiveRecord::Base
#  enumerated :gender, {:male => "Sir", :female => "Madam"}
#end
#
#class UserI18n < ActiveRecord::Base
#  enumerated :gender, [:male, :female]
#end