require 'spec_helper'

describe HairsHelper do
  it { should have_defined_method :user_hairs }
  it { should_not have_defined_method :user_genders }
  it { should_not have_defined_method :user_nationalities }

  context "should include method" do
    subject { Class.new { include HairsHelper }.new }

    its(:user_hairs) { should  == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]] }
  end

  context "parametrized" do
    subject { Class.new { include HairsHelper }.new }

    it "should return user hairs in brown, black, blond, red order" do
      subject.user_hairs(:order => %w(brown black blond red)).should == [["Brown hair", :brown], ["Black hair", :black], ["Blond hair", :blond], ["Red hair", :red]]
    end

    it "should return user hairs except brown, black and blond" do
      subject.user_hairs(:except => %w(brown black blond)).should == [["Red hair", :red]]
    end

    it "should return only blond, red user hairs" do
      subject.user_hairs(:only => %w(blond red), :order => %w(blond red)).should == [["Blond hair", :blond], ["Red hair", :red]]
    end
  end
end