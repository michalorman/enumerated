class UserDefault < ActiveRecord::Base
  enumerated :gender, [:male, :female]
end

class UserDefined < ActiveRecord::Base
  enumerated :gender, {:male => "Sir", :female => "Madam"}
end

class UserI18n < ActiveRecord::Base
  enumerated :gender, [:male, :female]
end