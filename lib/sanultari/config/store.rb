module SanUltari
  class Config
    class Store
      def [] name
        @values ||= {}

        @values[name] = SanUltari::Config.new name if @values[name] == nil
        @values[name]
      end

      def []= name, value
        @values ||= {}

        @values[name] = value
      end

      def keys
        return [] if @values == nil
        @values.keys
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
end
