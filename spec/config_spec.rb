require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'tempfile'

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
    @fixture.name.should be_nil
    @fixture.path.should eql File.expand_path('.')
  end

  it "should create object with yaml file" do
    @fixture.init! 'config.yml'
    @fixture.test.should eql 'a'
    @fixture.alpha.should eql 12345
    @fixture.list_test.length.should eql 3
    @fixture.list.length.should eql 2
    @fixture.name.should eql 'config'
    @fixture.path.should eql File.expand_path('.')
  end

  it "should create tree object with yaml file" do
    @fixture.init! 'tree.yml'
    @fixture.a.should eql 'test'
    @fixture.test.a.should eql 'confirm'
  end

  it "should dump to yaml file" do
    test_file = 'tree.yml'
    @fixture.init! test_file

    tmp_file = nil
    Tempfile.open(['dump', '.yml']) do |f|
      tmp_file = f
      @fixture.save tmp_file.path
    end

    File.open(test_file, 'r') do |o|
      File.open(tmp_file.path, 'r') do |f|
        dump = cleanup f.read
        origin = cleanup o.read
        dump.should eql origin
      end
    end

    tmp_file.unlink
  end

  after :all do
    Dir.chdir @origin
  end

  private
  def cleanup string
    string.gsub! /^$(\r|\n|\r\n)/, ''
    string.gsub! /^---$(\r|\n|\r\n)/, ''
    string.each_line.sort.join
  end
end
