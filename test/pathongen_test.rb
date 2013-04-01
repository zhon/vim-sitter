require "vim_sitter/pathogen"
require "vim_sitter/vim_dir"

require_relative 'test_helper'

class PathogenTest < FlexMockTestCase

  def test_install_gets_pathoten
    flexmock(VimDir).should_receive(:cp_to_autoload)
    flexmock(VimDir).should_receive(:add_to_vimrc)
    flexmock(Gitter)
      .should_receive(:get)
      .with('tpope', 'vim-pathogen')
      .once
    Pathogen.install
  end

  def test_install_copies_pathogen_to_autoload
    flexmock(Gitter).should_receive(:get)
    flexmock(VimDir).should_receive(:add_to_vimrc)
    flexmock(VimDir)
      .should_receive(:cp_to_autoload)
      .with(%r{vim-pathogen/autoload/pathogen.vim})
      .once
    Pathogen.install
  end

  def test_install_adds_to_vimrc
    flexmock(Gitter).should_receive(:get)
    flexmock(VimDir).should_receive(:cp_to_autoload)
    flexmock(VimDir)
      .should_receive(:add_to_vimrc)
      .with("call pathogen#infect()\ncall pathogen#helptags()")
      .once
    Pathogen.install
  end

end
