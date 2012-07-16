require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SanUltari::Config" do
  before :each do
    @fixture = SanUltari::Config.new
  end

  it "should not have properties" do
    expected = 'test'
    @fixture.a = expected
    @fixture.a.should be_equal expected
    @fixture.class.instance_methods.should_not include :a
  end
end
