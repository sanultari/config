# coding: utf-8
require 'sanultari/config'
require 'singleton'

module SanUltari
  class GlobalConfig < Config
    include Singleton

    def self.method_missing(method_name, *args, &block)
      SanUltari::GlobalConfig.instance.send method_name, *args, &block
    end
  end
end
