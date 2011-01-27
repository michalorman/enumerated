require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }
  it { should respond_to :hair }
  it { should respond_to :hair= }
  it { should respond_to :height }
  it { should respond_to :height= }

  its(:gender) { should == nil }
  its(:gender_label) { should == nil }
  its(:hair) { should == nil }
  its(:hair_label) { should == nil }

  context "class" do
    subject { User.new.class }

    it { should respond_to :genders }
    it { should respond_to :hairs }
    it { should respond_to :heights }

    its(:genders) { should == [["Male", :male], ["Female", :female]] }
    its(:hairs) { should == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]] }
    its(:heights) { should == [["Tall", :tall], ["Short", :short]] }
  end

  context "when assigned a gender" do
    before(:each) { subject.gender = :female }

    its(:gender) { should == :female }
    its(:gender_label) { should == "Female" }
#    its(:female?) { should == true }
#    its(:male?) { should == false }
  end

end