require 'spec_helper'

describe Dog do

  context "when not assigned a name" do
    before(:each) { subject.valid? }

    it { should_not be_valid }
    its(:errors) { should_not be_empty }
    its(:errors) { should have(1).error_on(:name)}
  end

  context "when assigned a name" do
    before(:each) { subject.max!; subject.valid? }

    it { should be_valid }
    its(:name) { should == :max }
    its(:errors) { should be_empty }
  end

  context "when assigned an invalid name" do
    before(:each) { subject.name = :woof; subject.valid? }

    it { should_not be_valid }
    its(:errors) { should_not be_empty }
    its(:errors) { should have(1).error_on(:name)}
  end

  context "when assigned a blank name" do
    before(:each) { subject.name = ""; subject.valid? }

    its(:name) { should == "" }
    it { should_not be_valid }
    its(:errors) { should_not be_empty }
    its(:errors) { should have(1).error_on(:name)}
  end

end