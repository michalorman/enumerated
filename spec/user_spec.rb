require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }

  its(:class) { should respond_to :genders }

  context "class method :genders" do
    it "should return declared enumerations with labels" do
      subject.class.genders.should == [["Male", :male], ["Female", :female]]
    end
  end

end