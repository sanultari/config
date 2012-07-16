require 'sanultari/config/store'
require 'yaml'

module SanUltari
  class Config
    attr_accessor :name

    def initialize name = nil
      @name = name || nil
      @store_class = Class.new SanUltari::Config::Store
      @store = @store_class.new
    end

    def init! path = nil
      return nil if path == nil
      config_hash = YAML.load_file make_path(path)
      hash_to_config(config_hash)
    end

    def save
    end

    def hash_to_config hash
      raise Exception.new unless hash.instance_of?(Hash)

      hash.each_pair do |key, value|
        t_value = value
        if value.instance_of? Hash
          t_value = Config.new key
          t_value.hash_to_config value 
        end
          
        @store.send("#{key}=".to_sym, t_value)
      end
    end

    def make_path path
      if path.start_with?('/', '\\')
        return path
      else
        return File.expand_path(path, Dir.getwd)
      end
    end

    def method_missing(method_name, *args, &block)
      @store.send method_name, *args, &block
    end
  end
end
