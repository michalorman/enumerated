require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }
  it { should respond_to :hair }
  it { should respond_to :hair= }

  its(:class) { should respond_to :genders }
  its(:class) { should respond_to :hairs }

  context "class method :genders" do
    it "should return declared enumerations with labels" do
      subject.class.genders.should == [["Male", :male], ["Female", :female]]
    end
  end

  context "class method :hairs" do
    it "should return declared enumerations with labels" do
      subject.class.hairs.should == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]]
    end
  end

end