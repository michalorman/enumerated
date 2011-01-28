require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }
  it { should respond_to :hair }
  it { should respond_to :hair= }
  it { should respond_to :nationality }
  it { should respond_to :nationality= }

  its(:gender) { should == nil }
  its(:gender_label) { should == nil }
  its(:hair) { should == nil }
  its(:hair_label) { should == nil }

  context "class" do
    subject { User.new.class }

    it { should respond_to :genders }
    it { should respond_to :hairs }
    it { should respond_to :nationalities }

    its(:genders) { should == [["Male", :male], ["Female", :female]] }
    its(:hairs) { should == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]] }
    its(:nationalities) { should == [["English", :gbr], ["Spanish", :esp], ["Polish", :pol]] }
  end

  context "when assigned a gender" do
    before(:each) { subject.gender = :female }

    its(:gender) { should == :female }
    its(:gender_label) { should == "Female" }
    its(:female?) { should == true }
    its(:male?) { should == false }
  end

  context "when assigned a gender using bang method" do
    before(:each) { subject.male! }

    its(:gender) { should == :male }
    its(:gender_label) { should == "Male" }
    its(:female?) { should == false }
    its(:male?) { should == true }
  end

  context "when assigned a hair" do
    before(:each) { subject.hair = :blond }

    its(:hair) { should == :blond }
    its(:hair_label) { should == "Blond hair" }
    its(:black?) { should == false }
    its(:brown?) { should == false }
    its(:red?) { should == false }
    its(:blond?) { should == true }
  end

  context "when assigned a hair using bang method" do
    before(:each) { subject.red! }

    its(:hair) { should == :red }
    its(:hair_label) { should == "Red hair" }
    its(:black?) { should == false }
    its(:brown?) { should == false }
    its(:red?) { should == true }
    its(:blond?) { should == false }
  end

  context "when assigned a nationality" do
    before(:each) { subject.nationality = :esp }

    its(:nationality) { should == :esp }
    its(:nationality_label) { should == "Spanish" }
    its(:gbr?) { should == false }
    its(:esp?) { should == true }
    its(:pol?) { should == false }
  end

  context "when assigned a nationality using bang method" do
    before(:each) { subject.pol! }

    its(:nationality) { should == :pol }
    its(:nationality_label) { should == "Polish" }
    its(:gbr?) { should == false }
    its(:esp?) { should == false }
    its(:pol?) { should == true }
  end

end