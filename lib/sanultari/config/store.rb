# coding: utf-8
module SanUltari
  class Config
    # SanUltari::Config의 설정값들을 실제로 저장하기 위한 객체
    # method 기반으로 동작하므로, method 이름을 격리하기 위하여 상속받은 동적 타입을 생성하여 사용한다.
    #
    # @author Jeong, Jiung
    # @see SanUltari::Config
    class Store
      # 기본 인덱서
      #
      # @param [String] name 실제로 저장된 값에 접근하기 위한 접근자
      def [] name
        @values ||= {}

        @values[name] = SanUltari::Config.new name if @values[name] == nil
        @values[name]
      end

      # 기본 인덱서 세터
      #
      # @param [String] name 값을 저장할 이름. 메서드 이름으로 변경된다.
      # @param [Object] value 저장될 값. 현재 테스트된 타입은 Primary types과 List, Hash에 한한다.
      def []= name, value
        @values ||= {}

        @values[name] = value
      end

      # 현재 저장되어 있는 설정의 Key값 컬렉션을 반환한다.
      def keys
        return [] if @values == nil
        @values.keys
      end

      # 설정값에 대해서 Getter와 Setter를 동적으로 생성하기 위한 Handler.
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
