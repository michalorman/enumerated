require 'spec_helper'

describe UserDefaultsHelper do
  it { should have_defined_method :user_default_genders }
end

class Includes
  include UserDefaultsHelper
end

describe Includes do
  its(:user_default_genders) { should == [["Male", :male], ["Female", :female]] }
end