require 'vim_sitter/gitter'

module VimSitter
  class Pathogen

    def self.install
      Gitter.get 'tpope', 'vim-pathogen'
      VimDir.cp_to_autoload 'vim-pathogen/autoload/pathogen.vim'
    end

  end
end
