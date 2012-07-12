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

  it "should set tree value" do
    expected = 'test'
    @config.a.b = expected
    @config.a.should_not be_nil
    @config.a.b.should be_equal expected
  end

  it "should set tree value with block" do
    expected = 'test'
    @config.a do |conf|
      conf.b = expected
      conf.c = 3
    end
    @config.a.b.should be_equal expected
    @config.a.c.should be_equal 3
  end
end
