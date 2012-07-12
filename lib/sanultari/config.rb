module SanUltari
  class Config
    attr_accessor :name, :values

    def initialize name = nil
      @name = name || nil
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
    def [] name
      @values ||= {}

      @values[name] = SanUltari::Config.new name if @values[name] == nil
      @values[name]
    end

    def []= name, value
      @values ||= {}

      @values[name] = value
    end

    def method_missing(method_name, *args, &block)
      name = method_name.to_s
      name.chomp!('=')

      self.class.instance_eval do
        define_method(name.to_sym) do |&blk|
          blk.call self[name] if blk != nil
          self[name]
        end if not public_methods.include? name.to_sym

        define_method("#{name}=".to_sym) do |value|
          self[name] = value
        end
      end

      send method_name, *args, &block
    end
  end
end
