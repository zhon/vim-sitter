require 'vim_sitter/vim_dir'
require 'yaml/store'

module VimSitter
  class Config

    @@config = nil

    def self.create
      unless File.exist?("#{VimDir.base_dir}/config.yaml")
        store = YAML::Store.new "#{VimDir.base_dir}/config.yaml"
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
      @@config = YAML::load_file "#{VimDir.base_dir}/config.yaml"
    end

    def self.reset
      @@config = nil
    end

  end
end
