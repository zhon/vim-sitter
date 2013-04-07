require 'vim_sitter/vim_dir'
require 'yaml/store'

module VimSitter
  class Config

    def self.create
      unless File.exist?("#{VimDir.base_dir}/config.yaml")
        store = YAML::Store.new "#{VimDir.base_dir}/config.yaml"
        store.transaction do
          store['tpope'] = [ 'vim-pathogen', 'vim-sensible' ]
        end
      end
    end

  end
end
