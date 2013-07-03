
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

  def test_vimrc_path_on_windows
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(true)
      .once
    assert_match /_vimrc/, VimDir.vimrc_path
  end

  def test_vimrc_path_on_unix_and_mac
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(false)
      .once
    assert_match /\.vimrc/, VimDir.vimrc_path
  end

  def test_base_dir_on_windows
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(true)
      .once
    assert_match /vimfiles/, VimDir.base_dir
  end

  def test_base_dir_on_unix_and_mac
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(false)
      .once
    assert_match /\.vim/, VimDir.base_dir
  end

  def test_data_dir_on_windows
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(true)
      .once
    assert_match /AppData/, VimDir.data_dir
  end

  def test_data_dir_on_mac
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(false)
      .once
      .should_receive(:mac?)
      .and_return(true)
      .once
    assert_match /Library\/Vim/, VimDir.data_dir
  end

  def test_data_dir_on_linux
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(false)
      .should_receive(:mac?)
      .and_return(false)
      .should_receive(:linux?)
      .and_return(true)
      .once
    assert_match /\.vim/, VimDir.data_dir
  end

  def test_data_dir_raises_on_unknown_os
    flexmock(VimDir)
      .should_receive(:windows?)
      .and_return(false)
      .should_receive(:mac?)
      .and_return(false)
      .should_receive(:linux?)
      .and_return(false)
      .once
    assert_raises(RuntimeError) {
      VimDir.data_dir
    }
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
    flexmock(File)
      .should_receive(:exist?)
      .and_return(true)
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
    flexmock(File)
      .should_receive(:exist?)
      .and_return(true)
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

  def test_add_to_vimrc_creates_file
    flexmock(File)
      .should_receive(:exist?)
      .and_return(false)
      .once
    flexmock(FileUtils)
      .should_receive(:touch)
      .with(/vimrc$/)
      .once
      .should_receive(:copy_file)
      .never
    flexmock(IO)
      .should_receive(:readlines)
      .and_return(["something\n", "silly\n"])
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
