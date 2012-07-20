require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SanUltari::Config::Store" do
  before :each do
    @fixture = SanUltari::Config::Store.new
  end

  it "should initialze" do
    SanUltari::Config::Store.new
  end

  it "should set plain value" do
    expected = 'test'
    @fixture.a = expected
    @fixture.a.should be_equal expected
  end

  it "should set tree value" do
    expected = 'test'
    @fixture.a.b = expected
    @fixture.a.should_not be_nil
    @fixture.a.b.should be_equal expected
  end

  it "should set tree value with block" do
    expected = 'test'
    @fixture.a do |conf|
      conf.b = expected
      conf.c = 3
    end
    @fixture.a.b.should be_equal expected
    @fixture.a.c.should be_equal 3
  end
end
