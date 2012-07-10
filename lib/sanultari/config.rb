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

    def hash_to_config hash
      raise Exception.new unless hash.instance_of?(Hash)

      config = Dssb::Config.new
      hash.each_pair do |key, value|
        config.send("#{key}=".to_sym, value)
      end

      config
    end

    def method_missing(method_name, *args, &block)
      name = method_name.to_s
      name.chomp!('=')

      @values ||= {}

      if method_name.to_s.end_with? '='
        self.class.instance_eval do
          define_method(name.to_sym) do
            @values[name]
          end if not public_methods.include? name.to_sym

          define_method(method_name) do |value|
            @values[name] = value
          end
        end
      else
        @values[name] ||= Dssb::Config.new name

        self.class.instance_eval do
          define_method(method_name) do |&blk|
            @values[name]

            blk.call @values[name] if block_given?
          end if not public_methods.include? name.to_sym
        end
      end

      send method_name, *args, &block
    end
  end
end
