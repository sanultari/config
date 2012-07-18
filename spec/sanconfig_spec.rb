require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SanUltari::Config" do
  before :all do
    @origin = Dir.getwd
    Dir.chdir File.expand_path('../fixture', File.dirname(__FILE__))
  end

  before :each do
    @fixture = SanUltari::Config.new
  end

  it "should not have properties" do
    expected = 'test'
    @fixture.a = expected
    @fixture.a.should be_equal expected
    @fixture.class.instance_methods.should_not include :a
  end

  it "should load from yaml file" do
    config = SanUltari::Config.new
    config.init!
  end

  after :all do
    Dir.chdir @origin
  end
end
