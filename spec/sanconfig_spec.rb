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

  it "should create object without yaml file" do
    @fixture.init!
  end

  it "should create object with yaml file" do
    @fixture.init! 'config.yml'
    @fixture.test.should eql 'a'
    @fixture.alpha.should eql 12345
    @fixture.list_test.length.should eql 3
    @fixture.list.length.should eql 2
  end

  it "should create tree object with yaml file" do
    @fixture.init! 'tree.yml'
    @fixture.a.should eql 'test'
    @fixture.test.a.should eql 'confirm'
  end

  after :all do
    Dir.chdir @origin
  end
end
