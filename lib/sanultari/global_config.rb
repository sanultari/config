# coding: utf-8
require 'sanultari/config'
require 'singleton'

module SanUltari
  # Application 전역으로 쓸 수 있는 Singleton 객체
  # @author Jeong, Jiung
  # @see Singleton
  class GlobalConfig < Config
    include Singleton

    # class method 접근을 singleton instance method 접근으로 변경
    def self.method_missing(method_name, *args, &block)
      SanUltari::GlobalConfig.instance.public_send method_name, *args, &block
    end
  end
end
