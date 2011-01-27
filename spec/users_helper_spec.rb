require 'spec_helper'

describe UsersHelper do
  it { should have_defined_method :user_genders }
  it { should_not have_defined_method :user_hairs }

  context "should include method" do
    subject { Class.new { include UsersHelper }.new }

    its(:user_genders) { should == [["Male", :male], ["Female", :female]] }
  end
end