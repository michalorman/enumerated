require 'spec_helper'

describe UsersHelper do
  it { should have_defined_method :user_genders }
end

class IncludingUsersHelper
  include UsersHelper
end

describe IncludingUsersHelper do
  its(:user_genders) { should == [["Male", :male], ["Female", :female]] }
end