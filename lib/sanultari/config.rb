# coding: utf-8
require 'sanultari/config/store'
require 'yaml'

# @author Jeong, Jiung
module SanUltari
  # @author Jeong, Jiung
  class Config
    attr_accessor :name, :path, :store

    # 생성자
    #
    # @param [String] name 설정 Key의 이름. 넘기지 않으면 nil이 설정된다.
    def initialize name = nil
      @name = name || nil
      @path = File.expand_path '.'
      @store_class = Class.new SanUltari::Config::Store
      @store = @store_class.new
    end

    # Config 객체 초기화
    #
    # @param [String] path 읽어 들일 설정 파일의 위치. 넘기지 않으면 아무것도 설정하지 않는다.
    def init! path = nil
      return nil if path == nil
      if @name == nil
        @name = File.basename path, '.yml'
        @path = File.expand_path File.dirname(path), @path
      end
      config_hash = YAML.load_file make_path
      from_hash(config_hash)
    end

    # Config 객체를 지정된 위치에 YAML 포맷으로 덤프한다.
    #
    # @param [String] path 기록할 파일의 위치. 넘기지 않을 경우 기본값이 셋팅된다. {#init!}을 통해 파일을 읽은 경우에는 읽었던 파일의 위치. 그렇지 않으면 현재 디렉토리내의 config.yml을 대상으로 한다. {#path=}가 설정된 경우에는 {#path}하위에 config.yml을 만든다.
    # @see SanUltari::Config#init!
    # @see SanUltari::Config#path=
    # @see SanUltari::Config#path
    def save path = nil
      @name = 'config' if @name == nil
      path = make_path if path == nil
      
      File.open(make_path(path), 'w') do |f|
        YAML.dump(to_hash, f)
      end
    end

    # Config 객체를 {Hash Ruby Hash}로부터 생성한다.
    #
    # @param [Hash] hash {SanUltari::Config}로 변환할 Hash객체
    # @see Hash
    def from_hash hash
      raise Exception.new unless hash.instance_of?(Hash)

      hash.each_pair do |key, value|
        t_value = value
        if value.instance_of? Hash
          t_value = Config.new key
          t_value.from_hash value 
        end
          
        @store.send("#{key}=".to_sym, t_value)
      end
    end

    # 현재 Config 객체를 {Hash Ruby Hash}로 변환한다.
    #
    # @return [SanUltari::Config] {SanUltari::Config}객체가 변환된 Hash객체
    # @see Hash
    def to_hash
      hash = {}
      @store.keys.each do |key|
        value = @store.send key.to_sym
        value = value.to_hash if value.instance_of? SanUltari::Config
        hash[key] = value
      end
      hash
    end

    # 현재 패스로부터 적절한 YAML 파일 경로를 만들어낸다.
    #
    # @param [String] path YAML 파일의 위치. 지정되지 않으면, {#name}, {#path}로부터 기본 패스를 만들어낸다.
    def make_path path = nil
      return File.expand_path "#{@name}.yml", @path if path == nil
      if path.start_with?('/', '\\')
        return path
      else
        return File.expand_path(path, @path)
      end
    end

    # 존재하지 않는 메소드 처리를 위한 핸들러
    def method_missing(method_name, *args, &block)
      @store.send method_name, *args, &block
    end
  end
end
