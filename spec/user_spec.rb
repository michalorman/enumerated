require 'spec_helper'

describe User do

  it { should include_module Enumerated }
  it { should respond_to :gender }
  it { should respond_to :gender= }
  it { should respond_to :hair }
  it { should respond_to :hair= }

  context "class" do
    subject { User.new.class }

    it { should respond_to :genders }
    it { should respond_to :hairs }

    its(:genders) { should == [["Male", :male], ["Female", :female]] }
    its(:hairs) { should == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]] }
  end

end