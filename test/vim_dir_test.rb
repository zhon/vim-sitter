
require "vim_sitter/vim_dir"

require_relative 'test_helper'

class VimDirTest < FlexMockTestCase

  def test_create_windows_dirs
    check :create_bundle,   /vimfiles.bundle/
    check :create_autoload, /vimfiles.autoload/
    check :create_swap,     /AppData.+Vim.swap/
    check :create_backup,   /AppData.+Vim.backup/
    check :create_undo,     /AppData.+Vim.undo/
  end

  def test_cd_to_bundle
    flexmock(FileUtils)
      .should_receive(:cd)
      .with(/bundle\/$/)
      .once
    VimDir.cd_to_bundle
  end

  def test_cd_to_bundle_repo
    flexmock(FileUtils)
      .should_receive(:cd)
      .with(/repo$/)
      .once
    VimDir.cd_to_bundle 'repo'
  end

  def test_repo_exists
    flexmock(File)
      .should_receive(:exists?)
      .with(/repo/)
      .once
    VimDir.repo_exists? 'repo'
  end

  def test_cp_to_autoload
    flexmock(FileUtils)
      .should_receive(:cp)
      .with(%r{/bundle/hello}, /autoload/)
      .once
    VimDir.cp_to_autoload 'hello'
  end

  def test_add_to_vimrc_does_nothing_if_already_there
    flexmock(IO)
      .should_receive(:readlines)
      .with(/vimrc$/)
      .and_return(["something\n", "silly\n"])
      .once
    flexmock(FileUtils)
      .should_receive(:copy_file)
      .never
    VimDir.add_to_vimrc "something\nsilly"
  end

  def test_add_to_vimrc
    require 'tempfile'
    tempfile_mock = flexmock(close:nil, unlink:nil, print:nil,path:'',binmode:nil)
    flexmock(Tempfile).should_receive(:new).and_return(tempfile_mock)
    flexmock(IO)
      .should_receive(:readlines)
      .and_return(["some config\n", "silly\n"])
      .once
    flexmock(FileUtils)
      .should_receive(:copy_file)
      .with(//, /vimrc$/)
      .once
    VimDir.add_to_vimrc "something\nsilly"
  end

  def check(method, regex)
    dir = VimDir
    flexmock(FileUtils)
      .should_receive(:mkdir_p)
      .once
      .with(regex)
    dir.send method
  end

end
