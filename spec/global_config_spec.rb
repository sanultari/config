require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SanUltari::Config" do
  it "should have static accessor" do
    SanUltari::GlobalConfig.test = 1
    SanUltari::GlobalConfig.test.should eql 1
  end
end
