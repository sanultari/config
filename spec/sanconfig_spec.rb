require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SanUltari::Config" do
  before :each do
    @config = SanUltari::Config.new
  end
  it "should initialze" do
    SanUltari::Config.new
  end

  it "should set plain value" do
    expected = 'test'
    @config.a = expected
    @config.a.should be_equal expected
  end
end
