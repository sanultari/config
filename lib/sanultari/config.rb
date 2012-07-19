require 'sanultari/config/store'
require 'yaml'

module SanUltari
  class Config
    attr_accessor :name, :path

    def initialize name = nil
      @name = name || nil
      @path = File.expand_path '.'
      @store_class = Class.new SanUltari::Config::Store
      @store = @store_class.new
    end

    def init! path = nil
      return nil if path == nil
      if @name == nil
        @name = File.basename path, '.yml'
        @path = File.expand_path File.dirname(path), @path
      end
      config_hash = YAML.load_file make_path
      from_hash(config_hash)
    end

    def save path = nil
      @name = 'config' if @name == nil
      path = make_path if path == nil
      
      File.open(make_path(path), 'w') do |f|
        YAML.dump(to_hash, f)
      end
    end

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

    def to_hash
      hash = {}
      @store.keys.each do |key|
        value = @store.send key.to_sym
        value = value.to_hash if value.instance_of? SanUltari::Config
        hash[key] = value
      end
      hash
    end

    def make_path path = nil
      return File.expand_path "#{@name}.yml", @path if path == nil
      if path.start_with?('/', '\\')
        return path
      else
        return File.expand_path(path, @path)
      end
    end

    def method_missing(method_name, *args, &block)
      @store.send method_name, *args, &block
    end
  end
end
