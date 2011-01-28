require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }
  it { should respond_to :hair }
  it { should respond_to :hair= }
  it { should respond_to :nationality }
  it { should respond_to :nationality= }
  it { should be_valid }

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
    its(:nationalities) { should == [["English", "gbr"], ["Spanish", "esp"], ["Polish", "pol"]] }

    context "ordered" do
      it "genders" do
        subject.genders(:order => [:female, :male]).should == [["Female", :female], ["Male", :male]]
      end

      it "hairs" do
        subject.hairs(:order => [:red, :blond, :brown, :black]).should == [["Red hair", :red], ["Blond hair", :blond], ["Brown hair", :brown], ["Black hair", :black]]
      end

      it "nationalities" do
        subject.nationalities(:order => [:pol, :esp, :gbr]).should == [["Polish", "pol"], ["Spanish", "esp"], ["English", "gbr"]]
      end
    end

    context "except" do
      it "genders" do
        subject.genders(:except => [:male]).should == [["Female", :female]]
      end

      it "hairs" do
        subject.hairs(:order => [:red, :blond], :except => [:brown, :black]).should == [["Red hair", :red], ["Blond hair", :blond]]
      end

      it "nationalities" do
        subject.nationalities(:order => [:esp, :gbr], :except => [:pol]).should == [["Spanish", "esp"], ["English", "gbr"]]
      end
    end
  end

  context "when assigned a gender" do
    before(:each) { subject.gender = :female }

    it { should be_valid }
    its(:gender) { should == :female }
    its(:gender_label) { should == "Female" }
    its(:female?) { should == true }
    its(:male?) { should == false }
  end

  context "when assigned a gender using bang method" do
    before(:each) { subject.male! }

    it { should be_valid }
    its(:gender) { should == :male }
    its(:gender_label) { should == "Male" }
    its(:female?) { should == false }
    its(:male?) { should == true }
  end

  context "when assigned a gender as string" do
    before(:each) { subject.gender = "female" }

    it { should be_valid }
    its(:gender) { should == "female" }
    its(:gender_label) { should == "Female" }
    its(:female?) { should == true }
    its(:male?) { should == false }
  end

  context "when assigned an invalid gender" do
    before(:each) { subject.gender = :unknown; subject.valid? }

    it { should_not be_valid }

    its(:errors) { should_not be_empty }
    its(:errors) { should have(1).error_on(:gender) }
  end

  context "when assigned a blank gender" do
    before(:each) { subject.gender = "" }

    it { should be_valid }
    its(:gender) { should == "" }
    its(:gender_label) { should == nil }
    its(:female?) { should == false }
    its(:male?) { should == false }
  end

  context "when assigned a hair" do
    before(:each) { subject.hair = :blond }

    it { should be_valid }
    its(:hair) { should == :blond }
    its(:hair_label) { should == "Blond hair" }
    its(:black?) { should == false }
    its(:brown?) { should == false }
    its(:red?) { should == false }
    its(:blond?) { should == true }
  end

  context "when assigned a hair using bang method" do
    before(:each) { subject.red! }

    it { should be_valid }
    its(:hair) { should == :red }
    its(:hair_label) { should == "Red hair" }
    its(:black?) { should == false }
    its(:brown?) { should == false }
    its(:red?) { should == true }
    its(:blond?) { should == false }
  end

  context "when assigned a hair as string" do
    before(:each) { subject.hair = "brown" }

    it { should be_valid }
    its(:hair) { should == "brown" }
    its(:hair_label) { should == "Brown hair" }
    its(:black?) { should == false }
    its(:brown?) { should == true }
    its(:red?) { should == false }
    its(:blond?) { should == false }
  end

  context "when assigned a blank hair" do
    before(:each) { subject.hair = "" }

    it { should be_valid }
    its(:hair) { should == "" }
    its(:hair_label) { should == nil }
    its(:black?) { should == false }
    its(:brown?) { should == false }
    its(:red?) { should == false }
    its(:blond?) { should == false }
  end

  context "when assigned an invalid hair" do
    # Validation for :hair is turned off
    before(:each) { subject.hair = :curly; subject.valid? }

    it { should be_valid }
    its(:errors) { should be_empty }
  end

  context "when assigned a nationality" do
    before(:each) { subject.nationality = :esp }

    it { should be_valid }
    its(:nationality) { should == :esp }
    its(:nationality_label) { should == "Spanish" }
    its(:gbr?) { should == false }
    its(:esp?) { should == true }
    its(:pol?) { should == false }
  end

  context "when assigned a nationality using bang method" do
    before(:each) { subject.pol! }

    it { should be_valid }
    its(:nationality) { should == :pol }
    its(:nationality_label) { should == "Polish" }
    its(:gbr?) { should == false }
    its(:esp?) { should == false }
    its(:pol?) { should == true }
  end

  context "when assigned a nationality as string" do
    before(:each) { subject.nationality = "gbr" }

    it { should be_valid }
    its(:nationality) { should == "gbr" }
    its(:nationality_label) { should == "English" }
    its(:gbr?) { should == true }
    its(:esp?) { should == false }
    its(:pol?) { should == false }
  end

  context "when assigned a blank nationality" do
    before(:each) { subject.nationality = "" }

    it { should be_valid }
    its(:nationality) { should == "" }
    its(:nationality_label) { should == nil }
    its(:gbr?) { should == false }
    its(:esp?) { should == false }
    its(:pol?) { should == false }
  end

  context "when assigned an invalid hair" do
    before(:each) { subject.nationality = :rus; subject.valid? }

    it { should_not be_valid }

    its(:errors) { should_not be_empty }
    its(:errors) { should have(1).error_on(:nationality) }
  end

end