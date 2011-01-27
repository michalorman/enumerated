require 'spec_helper'

describe HairsHelper do
  it { should have_defined_method :user_hairs }
  it { should_not have_defined_method :user_genders }

  context "should include method" do
    subject { Class.new { include HairsHelper }.new }

    its(:user_hairs) { should  == [["Black hair", :black], ["Brown hair", :brown], ["Red hair", :red], ["Blond hair", :blond]] }
  end
end