
require 'vim_sitter/config'
require 'vim_sitter/gitter'

module VimSitter
  class Bundle

    def self.install
      Config.each do |key, value|
        value.each do |item|
          Gitter.get key, item
        end

      end
    end

  end
end
