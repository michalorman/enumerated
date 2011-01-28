require 'spec_helper'

describe UsersHelper do
  it { should have_defined_method :user_genders }
  it { should_not have_defined_method :user_hairs }
  it { should_not have_defined_method :user_nationalities }

  context "should include method" do
    subject { Class.new { include UsersHelper }.new }

    its(:user_genders) { should == [["Male", :male], ["Female", :female]] }
  end

  context "parametrized" do
    subject { Class.new { include UsersHelper }.new }

    it "should return user genders in female, male order" do
      subject.user_genders(:order => [:female, :male]).should == [["Female", :female], ["Male", :male]]
    end

    it "should return user genders except female" do
      subject.user_genders(:except => [:female]).should == [["Male", :male]]
    end

    it "should return only male as user genders" do
      subject.user_genders(:only => [:male]).should == [["Male", :male]]
    end
  end
end