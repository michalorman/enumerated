require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }
  it { should respond_to :hair }
  it { should respond_to :hair= }

  its(:gender) { should == nil }
  its(:gender_label) { should == nil }
  its(:hair) { should == nil }
  its(:hair_label) { should == nil }

  context "class" do
    subject { User.new.class }

    it { should respond_to :genders }
    it { should respond_to :hairs }

    its(:genders) { should == [["Male", :male], ["Female", :female]] }
    its(:hairs) { should == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]] }
  end

  context "when assigned gender" do
    before(:each) { subject.gender = :female }

    its(:gender) { should == :female }
    its(:gender_label) { should == "Female" }
  end

end