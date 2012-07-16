require 'sanultari/config/store'

module SanUltari
  class Config

    attr_accessor :name, :values

    def initialize name = nil
      @name = name || nil
      @store_class = Class.new SanUltari::Config::Store
      @store = @store_class.new
    end

#    def init!
#      config_hash = YAML.load_file File.expand_path('../../config/db.yml', File.dirname(__FILE__))
#      self.db = hash_to_config(config_hash)
#    end

#    def hash_to_config hash
#      raise Exception.new unless hash.instance_of?(Hash)
#
#      config = SanUltari::Config.new
#      hash.each_pair do |key, value|
#        config.send("#{key}=".to_sym, value)
#      end
#
#      config
#    end

    def method_missing(method_name, *args, &block)
      @store.send method_name, *args, &block
    end
  end
end
