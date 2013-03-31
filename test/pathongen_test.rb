require "vim_sitter/pathogen"
require "vim_sitter/vim_dir"

require_relative 'test_helper'

class PathogenTest < FlexMockTestCase

  def test_install_gets_pathoten
    flexmock(Gitter)
      .should_receive(:get)
      .with('tpope', 'vim-pathogen')
      .once
    flexmock(VimDir).should_receive(:cp_to_autoload)
    Pathogen.install
  end

  def test_install_copies_pathogen_to_autoload
    flexmock(Gitter).should_receive(:get)
    flexmock(VimDir)
      .should_receive(:cp_to_autoload)
      .with(%r{vim-pathogen/autoload/pathogen.vim})
      .once
    Pathogen.install
  end

end
