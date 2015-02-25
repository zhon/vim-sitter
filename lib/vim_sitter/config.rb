require 'vim_sitter/vim_dir'
require 'yaml/store'

module VimSitter
  class Config

    @@config = nil
    CONFIG_FILE = "#{VimDir.base_dir}/config.yaml"
    def self.create
      unless File.exist?(CONFIG_FILE)
        store = YAML::Store.new CONFIG_FILE
        store.transaction do
          store['tpope'] = [ 'vim-pathogen', 'vim-sensible' ]
        end
      end
    end

    def self.each &block
      reload unless @@config
      @@config.each &block
    end

    def self.bundles
      bundles = []
      Config.each do |k,v|
        bundles << v
      end
      bundles.flatten
    end

    def self.reload
      @@config = YAML::load_file CONFIG_FILE
    end

    def self.reset
      @@config = nil
    end

  end
end
